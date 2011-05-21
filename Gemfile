source 'http://rubygems.org'

gem 'rails', '3.1.0.beta1'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# Asset template engines
gem 'haml-rails'
gem 'haml', '~> 3.1.1'
gem 'sass'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'

gem 'jsonpath', '~> 0.2.3'
gem 'redcarpet', '~> 1.14.2'
gem 'coderay'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

group :production do
  gem 'pg'
  gem 'therubyracer-heroku', '0.8.1.pre3'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.3.1'
end

group :test do
end

group :development do
  gem 'heroku'
  gem 'hirb'
  gem 'wirble'
  gem 'ruby-debug19', :require => 'ruby-debug'
end