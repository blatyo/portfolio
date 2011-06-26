require 'spec_helper'

describe Article::Markup do
  describe "#body=" do
    it "should convert markdown to html" do
      article = Article.create(:title => "test", :body => "# header")      
      article.generated_body.should == "<h1>header</h1>\n"
    end
  end
end
