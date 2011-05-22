require 'open-uri'

module GithubAPI
  class << self
    def get_blobs(user, repository, branch)
      url = "https://github.com/api/v2/json/blob/all/#{user}/#{repository}/#{branch}"
      JSON.parse(open(url){|io| io.read})['blobs']
    end
    
    def get_file_with_blob(user, repository, blob)
      url = "https://github.com/api/v2/json/blob/show/#{user}/#{repository}/#{blob}"
      open(url){|io| io.read}
    end
    
    def get_file_with_file_name(user, repository, branch, file_name)
      blob = blob_for_file(user, repository, branch, file_name)
      get_file_with_blob(user, repository, blob)
    end
    
    def blob_for_file(user, repository, branch, file_name)
      get_blobs(user, repository, branch)[file_name]
    end
  end
end
