require 'redcarpet'
require 'coderay'

module Markup
  class << self
    def process(markdown)
      process_code_blocks(process_markdown(markdown))
    end
    
    private
    
    def process_markdown(markdown)
      Redcarpet.new(markdown, :fenced_code, :gh_blockcode).to_html
    end

    def process_code_blocks(markdown)
      markdown.gsub(/<pre lang="(.+?)">\s*<code>(.*?)<\/code><\/pre>/m) do
        code_block = CodeRay.scan($2, $1).div(:css => :class)
        {'&amp;' => '&', '&quot;' => '"', '&lt;' => '<', '&gt;' => '>'}.each do |escape, char|
          code_block.gsub!(escape, char)
        end
        code_block
      end
    end
  end
end