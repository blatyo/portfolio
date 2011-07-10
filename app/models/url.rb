class Url < ActiveRecord::Base
  belongs_to :linkable, :polymorphic => true
  
  validates_url :link
  
  class << self
    def update_association(linkable, links)
      urls = links.map{|link| Url.create(:link => link)}
      linkable.update_attributes(:urls => urls)
    end
  end
end