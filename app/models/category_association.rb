class CategoryAssociation < ActiveRecord::Base
  belongs_to :category
  belongs_to :categorical, :polymorphic => true
end
