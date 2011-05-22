require "#{Rails.root}/lib/post_receive_hook"
require "#{Rails.root}/lib/article_post_receive_hook"
require "#{Rails.root}/lib/markup"

class Article < ActiveRecord::Base
  include PostReceiveHook
  include ArticlePostReceiveHook
  
  def body=(markdown)
    self[:body] = Markup.process(markdown)
  end
end
