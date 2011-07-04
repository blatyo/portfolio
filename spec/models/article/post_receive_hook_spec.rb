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
    article.body.should == "bob"
    article.title.should == 'bobby'
    article.generated_body.should == "<p>bob</p>\n"
  end
  
  it "should update files that have been modified in the post receive hook" do
    article = Factory.create(:article)
    payload = {:commits => [commit([], ["1999-01-01 #{article.title}.md"], [])]}.to_json
    GithubAPI.stub(:get_file_with_file_name).and_return("bob")
    
    lambda do
      Article.post_receive(payload)
    end.should_not change(Article, :count)
    
    article.reload
    article.body.should == "bob"
    article.generated_body.should == "<p>bob</p>\n"
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
  
  describe "when a category is specified" do
    before(:each) do
      GithubAPI.stub(:get_file_with_file_name).and_return("bob")
    end
    
    context "and the category doesn't exist" do
      it "should create the category and then associate it with the article" do
        payload = {:commits => [commit(["2009-09-09 Category[awesome].md"], [], [])]}.to_json
        
        lambda do
          Article.post_receive(payload)
        end.should change(Category, :count).by(1)
        
        Article.last.category.name.should == "awesome"
      end
    end
    
    context "and the category does exist" do
      it "should associate the article with the category" do
        category = Factory.create(:category)
        payload = {:commits => [commit(["2009-09-09 Category[awesome].md"], [], [])]}.to_json
        
        lambda do
          Article.post_receive(payload)
        end.should_not change(Category, :count)
        
        Article.last.category == category
      end
    end
  end
  
  describe "when tags are specified" do
    before(:each) do
      GithubAPI.stub(:get_file_with_file_name).and_return("bob")
    end
    
    context "and the tags do not exist" do
      it "should create the tags and then associate them with the article" do
        payload = {:commits => [commit(["2009-09-09 Tag{cool, neat}.md"], [], [])]}.to_json
        
        lambda do
          Article.post_receive(payload)
        end.should change(Tag, :count).by(2)
        
        Article.last.tags.size.should == 2
      end
    end
    
    context "and the tags do exist" do
      it "should associate the article with the tags" do
        cool_tag, neat_tag = Factory.create(:tag), Factory.create(:tag, :name => "neat")
        payload = {:commits => [commit(["2009-09-09 Tag{cool, neat}.md"], [], [])]}.to_json
        
        lambda do
          Article.post_receive(payload)
        end.should_not change(Tag, :count)
        
        Article.last.tags.should == [cool_tag, neat_tag]
      end
    end
  end
 
  def commit(added, modified, removed)
    {:added => added, :modified => modified, :removed => removed}
  end
end