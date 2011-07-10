class Category < ActiveRecord::Base
  has_many :category_associations
  has_many :categorized, :through => :category_associations
  
  validates_presence_of :name
  
  
  class << self
    def update_association(categorical, category_name)
      category = Category.find_or_create_by_name(category_name || "None")
      categorical.update_attributes(:category => category)
    end
  end
end
