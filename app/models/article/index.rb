require "#{Rails.root}/lib/index"

class Article < ActiveRecord::Base
  module Index
    extend ActiveSupport::Concern
    
    included do
      after_save{|article| article.create_or_update_index if configatron.indextank.use}
      after_destroy{|article| article.remove_index if configatron.indextank.use}
    end
    
    module InstanceMethods
      def create_or_update_index
        doc = {
          :title => title,
          :text => body,
          :timestamp => created_at.to_time.to_i
        }
        doc[:tags] = tags.collect(&:name) unless tags.blank?
        index.document(id).add(doc)
        index.document(id).update_categories({:category => category.name}) if category
      end
      
      def remove_index
        index.document(id).delete
      end
      
      private
      
      def index
        self.class.index
      end
    end
    
    module ClassMethods
      def search(query, *categories)
        category_filter = categories.blank? ? {} : {:category_filters => {:category => categories}}
        results = index.search(query, category_filter)
        find(JsonPath.new('$..docid').on(results).map(&:to_i))
      end
      
      def index
        ::Index.get(configatron.indextank.articles_index)
      end
    end
  end
end