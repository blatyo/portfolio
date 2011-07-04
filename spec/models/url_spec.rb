require 'spec_helper'

describe Url do
  it{ should have_valid(:link).when("http://www.cool.com/") }
  it{ should_not have_valid(:link).when("cool") }
  it{ should_not have_valid(:link).when(nil) }
end
