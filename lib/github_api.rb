module GithubAPI
  class << self
    def get_blobs(user, repository, branch)
      url = "https://github.com/api/v2/json/blob/all/#{user}/#{repository}/#{branch}"
      JSON.parse(open(url){|io| io.read})['blobs']
    end
    
    def get_file_from_blob(user, repository, blob)
      url = "https://github.com/api/v2/json/blob/show/#{user}/#{repository}/#{blob}"
      open(url){|io| io.read}
    end
  end
end
