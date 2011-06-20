describe Article::PostReceiveHook do
  it "should delete files that have been removed in the post receive hook" do
    article = Factory.create(:article)
    payload = {:commits => [commit([], [], ["1999-01-01 #{article.title}.md"])]}.to_json
    lambda do
      Article.post_receive(payload)
    end.should change(Article, :count).by(-1)
  end
  
  it "should create files that have been added in the post receive hook" do
    payload = {:commits => [commit(["1999-01-01 bobby.md"], [], [])]}.to_json
    GithubAPI.stub(:get_file_with_file_name).and_return("bob")
    
    lambda do
      Article.post_receive(payload)
    end.should change(Article, :count).by(1)
    
    article = Article.first
    article.title.should == 'bobby'
    article.body.should == "<p>bob</p>\n"
  end
  
  it "should update files that have been modified in the post receive hook" do
    article = Factory.create(:article)
    payload = {:commits => [commit([], ["1999-01-01 #{article.title}.md"], [])]}.to_json
    GithubAPI.stub(:get_file_with_file_name).and_return("bob")
    
    lambda do
      Article.post_receive(payload)
    end.should_not change(Article, :count)
    
    article.reload
    article.body.should == "<p>bob</p>\n"
  end
  
  it "should ignoe a new file that has been added in the post receive hook if it doesn't match an article format" do
    payload = {:commits => [commit(['Rakefile'], [], [])]}.to_json
    
    lambda do
      Article.post_receive(payload)
    end.should_not change(Article, :count)
  end
  
  it "should ignore an updated file that has been modified in the post receive hook if it doesn't match an article format" do
    payload = {:commits => [commit([], ['Rakefile'], [])]}.to_json
    
    lambda do
      Article.post_receive(payload)
    end.should_not change(Article, :count)
  end
 
  def commit(added, modified, removed)
    {:added => added, :modified => modified, :removed => removed}
  end
end