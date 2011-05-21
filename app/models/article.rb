class Article < ActiveRecord::Base
  class << self
    def parse_file_name(file_name)
      file_name =~ /(\d{4}-\d{2}-\d{2})\s(.+)\.md/
      [$2, Date.parse($1)] #title, date
    end
  end
end
