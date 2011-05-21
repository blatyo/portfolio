require 'open-uri'
require 'json'
require "#{Rails.root}/lib/markup"
require "#{Rails.root}/lib/github_api"

namespace :articles do
  task :import => :environment do
    user, repository = ENV['repo'].split('/')
    articles = GithubAPI.get_blobs(user, repository, 'master').select{|article| article =~ /\d{4}-\d{2}-\d{2}/ }
    
    articles.each do |file_name, blob|
      title, date = Article.parse_file_name(file_name)
      body = Markup.process(GithubAPI.get_file_from_blob(user, repository, blob))
      
      article = Article.find_or_initialize_by_title(title)
      article.update_attributes(:body => body, :created_at => date, :updated_at => date)
    end
  end
end