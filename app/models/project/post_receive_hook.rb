require "#{Rails.root}/lib/github_api"

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
        attributes = {}
        
        if push.added_and_modified.include?('README.md')
          attributes[:readme] = GithubAPI.get_file_with_file_name(push.owner, push.repository, 'master', 'README.md')
        end
        
        if push.added_and_modified.include?('.meta')
          
        end
      end
    end
  end
end