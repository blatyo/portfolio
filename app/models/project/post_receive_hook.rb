require "#{Rails.root}/lib/github_api"
require 'yaml'

class Project < ActiveRecord::Base
  module PostReceiveHook
    extend ActiveSupport::Concern

    module ClassMethods
      def post_receive(push)
        @push = GithubAPI::Push.new(push)
        import_project
      end
    
    private
    
      attr_reader :push
      
      def import_project
        return unless readme? || meta?
        
        project = Project.find_or_initialize_by_name(push.repository)
        
        if readme?
          readme = GithubAPI.get_file_with_file_name(push.owner, push.repository, 'master', 'README.md')
          project.update_attributes(:readme => readme)
        end

        if meta?
          category_name, tag_names, urls = parse_meta
          project.urls.destroy_all
          
          Category.update_association(project, category_name)
          Tag.update_association(project, tag_names)
          Url.update_association(project, urls)
        end
      end
      
      def readme?
        push.added_and_modified.include?('README.md')
      end
      
      def meta?
        push.added_and_modified.include?('.meta')
      end
      
      def parse_meta
        meta = YAML.load(GithubAPI.get_file_with_file_name(push.owner, push.repository, 'master', '.meta'))
        category_name = meta[:category]
        tag_names = meta[:tags]
        urls = meta[:urls]
        
        [category_name || "None", tag_names || [], urls || []]
      end
    end
  end
end