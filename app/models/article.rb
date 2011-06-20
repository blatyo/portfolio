require "#{Rails.root}/lib/article/post_receive_hook"
require "#{Rails.root}/lib/markup"

class Article < ActiveRecord::Base
  include PostReceiveHook
  
  def body=(markdown)
    self[:body] = Markup.process(markdown)
  end
end
