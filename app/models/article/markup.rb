require "#{Rails.root}/lib/markup"

class Article < ActiveRecord::Base
  module Markup
    extend ActiveSupport::Concern
    
    included do
      before_save :create_or_update_generated_body
    end
    
    module InstanceMethods
      private
      
      def create_or_update_generated_body
        self.generated_body = ::Markup.process(self.body) if self.body_changed?
      end
    end
  end
end