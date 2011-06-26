require File.dirname(__FILE__) + "/article/post_receive_hook"
require File.dirname(__FILE__) + "/article/markup"
require File.dirname(__FILE__) + "/article/index"

class Article < ActiveRecord::Base
  include ::Article::PostReceiveHook
  include ::Article::Markup
  include ::Article::Index
  
  validates_presence_of :title, :body, :category
end
