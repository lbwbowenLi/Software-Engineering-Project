source 'https://rubygems.org'
ruby "2.3.0"




# Use HAML
# gem 'haml'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'omniauth-facebook', '~> 4.0.0'
gem 'will_paginate-bootstrap'
gem 'config'
gem 'will_paginate',           '3.0.7'
gem 'rails'
gem 'bootstrap-sass',       '3.2.0.0'
gem 'bcrypt',               '3.1.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'chartkick'
gem "omniauth-google-oauth2"




group :development, :test do
  gem 'sqlite3'
  gem 'byebug',      '3.4.0'
  gem 'web-console', '2.0.0.beta3'
  gem 'spring',      '1.1.3'
  gem 'railroady'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
  
  
  gem 'simplecov', :require => false
   #BDD
  gem 'cucumber-rails', :require =>false
  gem 'cucumber-rails-training-wheels'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  #TDD
  gem 'rspec-rails'
  
  #Fixtures & Factories
  gem "factory_girl_rails", "~> 4.0"
end

group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
  gem 'puma',           '3.1.0'
end
