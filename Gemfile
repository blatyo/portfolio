source 'http://rubygems.org'

gem 'rails', '3.1.0.rc1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Asset template engines
gem 'haml-rails'
gem 'haml', '~> 3.1.1'
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'redcarpet', '~> 1.14.2'
gem 'coderay'

gem 'jsonpath', '~> 0.2.3'

group :production do
  gem 'pg'
  gem 'therubyracer-heroku', '0.8.1.pre3'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.6.1'
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
end

group :development do
  gem 'heroku'
  gem 'hub'
  gem 'hirb'
  gem 'wirble'
end