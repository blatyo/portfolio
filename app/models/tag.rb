class Tag < ActiveRecord::Base
  has_many :taggables
  has_many :tagged, :through => :taggables
  
  validates_presence_of :name
  
  class << self
    def associate(taggable, tag_names)
      tag_names.map do |tag_name| 
        tag = Tag.find_or_create_by_name(tag_name)
        Taggable.create(:tag => tag, :taggable => taggable)
      end
    end
  end
end
