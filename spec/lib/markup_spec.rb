require 'spec_helper'
require "#{Rails.root}/lib/markup"

describe Markup do
  describe ".process" do
    it "should convert markdown with code to html" do
      Markup.process(markdown).should == html
    end
  end
  
  def markdown
    <<-Markdown.gsub(/^ {4}/, "")
    # Title
    
    * item 1
    * item 2
    
    ~~~~~ {ruby}
    
        def awesome!
          puts "awesome!"
        end
    
    ~~~~~
    Markdown
  end
  
  def html
    <<-HTML.gsub(/^ {4}/, "")
    <h1>Title</h1>
    
    <ul>
    <li>item 1</li>
    <li>item 2</li>
    </ul>
    
    <div class="CodeRay">
      <div class="code"><pre>
        <span class="r">def</span> <span class="fu">awesome!</span>
          puts "awesome!"
        <span class="r">end</span>
    
    </pre></div>
    </div>
    
    HTML
  end
end