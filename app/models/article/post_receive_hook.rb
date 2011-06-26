require "#{Rails.root}/lib/github_api"

class Article < ActiveRecord::Base
  module PostReceiveHook
    extend ActiveSupport::Concern

    module ClassMethods
      def post_receive(push)
        @push = GithubAPI::Push.new(push)
        import_articles
      end

      private
    
      attr_reader :push

      def import_articles
        create_or_update_articles
        delete_articles
      end
    
      def create_or_update_articles
        (push.added + push.modified).each do |file_name|
          title, time, category, tags = parse_file_name(file_name)
          if title && time
            body = GithubAPI.get_file_with_file_name(push.owner, push.repository, 'master', file_name)
            article = Article.find_or_initialize_by_title(title)
            article.update_attributes!(
              :body => body, 
              :category => category,
              :tags => tags,
              :created_at => time
            )
          end
        end
      end
    
      def delete_articles
        push.removed.each do |file_name|
          title, time, category, tags = parse_file_name(file_name)
          Article.find_by_title(title).delete if title && time
        end
      end

      def parse_file_name(file_name)
        file_name =~ /(\d{4}-\d{2}-\d{2})\s(.+?)(\[(.+)\])?(\{(.+)\})?\.md/
        [ $2.try(:strip),                 #title
          $1 ? Time.parse($1) : nil,      #date
          $4.try(:strip) || "None",       #category
          $6.try(:strip) || ""]  #tags
      end
    end
  end
end