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
  
  class Push
    def initialize(push)
      @push = JSON.parse(push)
      @called_group_files = false
    end
    
    def owner
      @owner ||= JsonPath.new('$..owner.name').on(@push).to_a.first
    end
    
    def repository
      @repository ||= JsonPath.new('$..repository.name').on(@push).to_a.first
    end
    
    def added
      group_files
      
      @added
    end
    
    def modified
      group_files
      
      @modified
    end
    
    def removed
      group_files
      
      @removed
    end
    
    private
    
    def group_files
      return if @called_group_files
      
      @added, @modified, @removed = [], [], []
      file_changes.each do |file_name, changes|
        if changes.last == :removed
          @removed << file_name
        elsif changes.first == :added
          @added << file_name
        else
          @modified << file_name
        end
      end
      
      @called_group_files = true
    end
    
    def file_changes
      changes = Hash.new{|h, k| h[k] = []}
      
      JsonPath.new('$..commits').on(@push).to_a.first.each do |commit|
        [:added, :modified, :removed].each do |change|
          JsonPath.new("$..#{change}").on(commit).to_a.flatten.each do |file_name|
            changes[file_name] << change
          end
        end
      end
      
      changes
    end
  end
end
