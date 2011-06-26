require "#{Rails.root}/lib/markup"

module Haml::Filters::Md
  include ::Haml::Filters::Base

  def render(text)
    Markup.process(text)
  end
end