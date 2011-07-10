class Project < ActiveRecord::Base
  include ::Project::PostReceiveHook
  include ::Project::Markup
  include ::Project::Index
  
  has_one :category_association, :as => :categorical
  has_one :category, :through => :category_association
  has_many :taggables, :as => :taggable
  has_many :tags, :through => :taggables
  has_many :urls, :as => :linkable
  
  validates_presence_of :name
  validates_presence_of :readme
end
