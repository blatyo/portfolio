require "#{Rails.root}/lib/post_receive_hook"

module ArticlePostReceiveHook
  extend ActiveSupport::Concern
  
  module ClassMethods
    def post_receive(push)
      super(push)
      import_articles
    end
    
    private
    
    def import_articles
      p push.new_files
      (push.new_files + push.updated_files).each do |file_name|
        title, date = parse_file_name(file_name)
        if title && date
          body = GithubAPI.get_file_with_file_name(push.owner, push.repository, 'master', file_name)
          puts "Creating #{title}"
          article = Article.find_or_initialize_by_title(title)
          article.update_attributes(:body => body, :created_at => date)
        end
      end
      
      push.deleted_files.each do |file_name|
        title, date = parse_file_name(file_name)
        Article.find_by_title(title).delete
      end
    end
    
    def parse_file_name(file_name)
      file_name =~ /(\d{4}-\d{2}-\d{2})\s(.+)\.md/
      [$2, $1 ? Date.parse($1) : nil] #title, date
    end
  end
end