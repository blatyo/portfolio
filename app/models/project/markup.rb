require "#{Rails.root}/lib/markup"

class Project < ActiveRecord::Base
  module Markup
    extend ActiveSupport::Concern
    
    included do
      before_save :create_or_update_generated_readme
    end
    
    module InstanceMethods
      private
      
      def create_or_update_generated_readme
        self.generated_readme = ::Markup.process(self.body) if self.body_changed?
      end
    end
  end
end