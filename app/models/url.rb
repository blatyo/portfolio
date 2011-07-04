class Url < ActiveRecord::Base
  belongs_to :linkable, :polymorphic => true
  
  validates_url :link
end