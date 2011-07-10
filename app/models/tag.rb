class Tag < ActiveRecord::Base
  has_many :taggables
  has_many :tagged, :through => :taggables
  
  validates_presence_of :name
  
  class << self
    def update_association(taggable, tag_names)
      tags = tag_names.map{|tag_name| Tag.find_or_create_by_name(tag_name)}
      taggable.update_attributes(:tags => tags)
    end
  end
end
