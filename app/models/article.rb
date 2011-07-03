require File.dirname(__FILE__) + "/article/post_receive_hook"
require File.dirname(__FILE__) + "/article/markup"
require File.dirname(__FILE__) + "/article/index"

class Article < ActiveRecord::Base
  include ::Article::PostReceiveHook
  include ::Article::Markup
  include ::Article::Index
  
  has_one :category_association, :as => :categorical
  has_one :category, :through => :category_association
  has_many :taggables, :as => :taggable
  has_many :tags, :through => :taggables
  
  validates_presence_of :title, :body
end
