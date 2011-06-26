require 'spec_helper'

describe Article::Index do
  it "should index a newly created article" do
    configatron.temp do
      configatron.indextank.use = true
      Article.should_receive(:index).and_return()
      Article.create({:title => "title", :body => "body", :category => "none"})
    end
  end
end