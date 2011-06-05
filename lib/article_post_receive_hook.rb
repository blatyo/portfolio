require "#{Rails.root}/lib/github_api"

module ArticlePostReceiveHook
  extend ActiveSupport::Concern

  module ClassMethods
    def post_receive(push)
      @push = Github::Push.new(push)
      import_articles
    end

    private
    
    attr_reader :push

    def import_articles
      create_or_update_article
      delete_articles
    end
    
    def create_or_update_articles
      (push.new_files + push.updated_files).each do |file_name|
        title, date, category, tags = parse_file_name(file_name)
        if title && date
          body = GithubAPI.get_file_with_file_name(push.owner, push.repository, 'master', file_name)
          article = Article.find_or_initialize_by_title(title)
          article.update_attributes(:body => body, :created_at => date)
        end
      end
    end
    
    def delete_articles
      push.deleted_files.each do |file_name|
        title, date, category, tags = parse_file_name(file_name)
        Article.find_by_title(title).delete
      end
    end

    def parse_file_name(file_name)
      file_name =~ /(\d{4}-\d{2}-\d{2})\s(.+?)(\[(.+)\])?(\{(.+)\})?\.md/
      [ $2.strip,                       #title
        $1 ? Date.parse($1) : nil,      #date
        $4.strip,                       #category
        $6 ? $6.strip.split(',') : []]  #tags
    end
  end
end