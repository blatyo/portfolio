require 'spec_helper'

describe Tag do
  it{ should have_valid(:name).when("cool") }
  it{ should_not have_valid(:name).when(nil) }
end
