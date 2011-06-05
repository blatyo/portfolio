require "#{Rails.root}/lib/github_api"

describe GithubAPI do
end

describe GithubAPI::Push do
  describe "#owner" do
    it "should return the owner name" do
      payload = {:repository => {:owner => {:name => name = "bob"}}}.to_json
      GithubAPI::Push.new(payload).owner.should == name
    end
  end
  
  describe "#repository" do
    it "should return the repository name" do
      payload = {:repository => {:name => name = "bob"}}.to_json
      GithubAPI::Push.new(payload).repository.should == name
    end
  end
  
  describe "#added" do
    it "should correctly assign a file that has just been added" do
      payload = {:commits => [
        commit([new_file = 'github_api_spec.rb'], [], [])
      ]}.to_json
      GithubAPI::Push.new(payload).added.should include(new_file)
    end
    
    it "should recognize a file that has been added, removed, and readded as a new file" do
      payload = {:commits => [
        commit([new_file = 'github_api_spec.rb'], [], []),
        commit([], [], [new_file]),
        commit([new_file], [], [])
      ]}.to_json
      GithubAPI::Push.new(payload).added.should include(new_file)
    end
    
    it "should recognize a file that has been added, updated, removed, and readded as a new file" do
      payload = {:commits => [
        commit([new_file = 'github_api_spec.rb'], [], []),
        commit([], [], [new_file]),
        commit([], [new_file], []),
        commit([new_file], [], [])
      ]}.to_json
      GithubAPI::Push.new(payload).added.should include(new_file)
    end
  end
  
  describe "#modified" do
    it "should correctly assign an updated file" do
      payload = {:commits => [
        commit([], [updated_file = 'github_api_spec.rb'], [])
      ]}.to_json
      GithubAPI::Push.new(payload).modified.should include(updated_file)
    end
    
    it "should recognize a file that has been removed and added" do
      payload = {:commits => [
        commit([], [], [updated_file = 'github_api_spec.rb']),
        commit([updated_file], [], []),
      ]}.to_json
      GithubAPI::Push.new(payload).modified.should include(updated_file)
    end
    
    it "should recognize a file that has been updated, removed, and added" do
      payload = {:commits => [
        commit([], [updated_file = 'github_api_spec.rb'], []),
        commit([], [], [updated_file]),
        commit([updated_file], [], []),
      ]}.to_json
      GithubAPI::Push.new(payload).modified.should include(updated_file)
    end
    
    it "should recognize a file that has been updated, removed, added, and updated" do
      payload = {:commits => [
        commit([], [updated_file = 'github_api_spec.rb'], []),
        commit([], [], [updated_file]),
        commit([updated_file], [], []),
        commit([], [updated_file], []),
      ]}.to_json
      GithubAPI::Push.new(payload).modified.should include(updated_file)
    end
  end
  
  describe "#removed" do
    it "should correctly assign a deleted file" do
      payload = {:commits => [
        commit([], [], [deleted_file = 'github_api_spec.rb'])
      ]}.to_json
      GithubAPI::Push.new(payload).removed.should include(deleted_file)
    end
    
    it "should recognize a file that has been added and deleted" do
      payload = {:commits => [
        commit([deleted_file = 'github_api_spec.rb'], [], []),
        commit([], [], [deleted_file])
      ]}.to_json
      GithubAPI::Push.new(payload).removed.should include(deleted_file)
    end
    
    it "should recognize a file that has been added, updated, and deleted" do
      payload = {:commits => [
        commit([deleted_file = 'github_api_spec.rb'], [], []),
        commit([], [deleted_file], []),
        commit([], [], [deleted_file])
      ]}.to_json
      GithubAPI::Push.new(payload).removed.should include(deleted_file)
    end
  end
  
  def commit(added, modified, removed)
    {:added => added, :modified => modified, :removed => removed}
  end
end