require 'spec_helper'

describe Tag do
  it "should require a name" do
    Tag.create.errors.size.should == 1
  end
end
