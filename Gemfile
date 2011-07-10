source 'http://rubygems.org'

gem 'rails', '3.1.0.rc4'
gem 'rake', '~> 0.9.2'

# Asset template engines
gem 'haml-rails'
gem 'haml', '~> 3.1.1'
gem 'sass-rails'
gem 'coffee-script'
gem 'coffee-filter', '~> 0.1.1'
gem 'uglifier'
gem 'jquery-rails'
gem 'redcarpet', '~> 1.14.2'
gem 'coderay'

gem 'configatron', '~> 2.8.1'
gem 'cells', '~> 3.6.0'

gem 'jsonpath', '~> 0.4.0'

gem 'truncate_html', "~> 0.5.1"
gem 'validate_url'

# Services
gem 'indextank'

group :production do
  gem 'pg'
  gem 'therubyracer-heroku', '0.8.1.pre3'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.6.1'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'ammeter' #gives an rspec supported plugin generator
end

group :test do
  gem 'factory_girl_rails'
  gem 'valid_attribute'
end

group :development do
  gem 'heroku'
  gem 'hub'
  gem 'hirb'
  gem 'wirble'
end