require 'spec_helper'

describe Project do
  it{ should have_valid(:name).when("bencodr") }
  it{ should_not have_valid(:name).when(nil) }
  
  it{ should have_valid(:readme).when("bencodr is awesome!") }
  it{ should_not have_valid(:readme).when(nil) }
end
