require 'spec_helper'

describe Article do
  describe "#body=" do
    it "should convert markdown to html" do
      article = Article.new(:title => "test", :body => "# header")      
      article.body.should == "<h1>header</h1>\n"
    end
  end
end
