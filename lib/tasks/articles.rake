require 'open-uri'
require 'json'
require "#{Rails.root}/lib/markup"
require "#{Rails.root}/lib/github_api"

namespace :articles do
  desc "Imports articles from specified repo"
  task :import => :environment do
    user, repository = ENV['repo'].split('/')
    articles = GithubAPI.get_blobs(user, repository, 'master').keys

    json = {
      commits: [{
        added: articles,
        modified: [],
        removed: [],
      }],
      repository: {
        name: repository,
        owner: {
          name: user
        }
      }
    }.to_json

    Article.post_receive(json)
  end
end