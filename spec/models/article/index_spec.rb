require 'spec_helper'

describe Article::Index do
  before :each do
    configatron.temp_start
    
    @index = mock(:index)
    @document = mock(:document)
    Article.stub!(:index).and_return(@index)
  end
  
  it "should index a newly created article" do
    configatron.indextank.use = true
    
    article = Factory.build(:article)
    category = mock_model(Category, :name => "neat")
    
    article.stub!(:category).and_return(category)
    
    @index.should_receive(:document).twice.and_return(@document)
    @document.should_receive(:add)
    @document.should_receive(:update_categories)
    
    article.save
  end
  
  it "should index an updated article" do
    article = Factory.create(:article)
    category = mock_model(Category, :name => "neat")
    tag = mock_model(Tag, :name => "cool")
    
    article.stub!(:category).and_return(category)
    article.stub!(:tags).and_return([tag])
    
    article.body = "silly"
    
    configatron.indextank.use = true
    
    @index.should_receive(:document).twice.and_return(@document)
    @document.should_receive(:add)
    @document.should_receive(:update_categories)
    
    article.save
  end
  
  it "should delete index of deleted article" do
    article = Factory.create(:article)
    
    configatron.indextank.use = true
    
    @index.should_receive(:document).and_return(@document)
    @document.should_receive(:delete)
    
    article.destroy
  end
  
  after :each do
    configatron.temp_end
  end
end