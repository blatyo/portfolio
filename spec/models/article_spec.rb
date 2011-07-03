require 'spec_helper'

describe Article do
  it{ should have_valid(:title).when("The once and future king") }
  it{ should_not have_valid(:title).when(nil) }
  
  it{ should have_valid(:body).when("It was the best of times, it was the worst of times.") }
  it{ should_not have_valid(:body).when(nil) }
end