source 'https://rubygems.org'

ruby '2.2.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'


## GEMS WE'RE ADDING ##
gem 'cancan'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

#ADDED by us
gem 'bootstrap-sass', '~> 3.3.6'
gem "haml-rails"
gem 'mailgun-ruby', '~>1.0.2', require: 'mailgun'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# For CSV files
gem 'roo'
gem "iconv", "~> 1.0.3"

# Use Unicorn as the app server
# gem 'unicorn'

gem "jquery-ui-rails"
gem 'jquery-datatables-rails', '~> 3.3.0'
gem 'ajax-datatables-rails'
gem "binding_of_caller"
gem 'less-rails-bootstrap', '~> 3.0'
gem "font-awesome-rails"
gem 'therubyracer'
gem 'chronic'
gem 'simplecov', :require => false, :group => :test


gem "paperclip", git: "git://github.com/thoughtbot/paperclip.git"
gem 'momentjs-rails', '>= 2.9.0'
gem 'bootstrap3-datetimepicker-rails', '~> 4.17.37'

# React is dope as fuck, does all work in the front-end
gem 'react-rails', '~> 1.6.0'

# Alex added
gem 'sprockets-rails', :require => 'sprockets/railtie'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem "codeclimate-test-reporter", group: :test, require: nil

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  gem 'rspec-rails', '~> 3.0'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'shoulda-matchers'
  gem 'coveralls', require: false
end

group :test do
  gem 'factory_girl_rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'railroady'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  
  gem "better_errors"
end

group :production do
  gem 'rails_12factor'
  gem 'rspec-rails', '~> 3.0'
  gem 'pg'
  gem 'coveralls', require: false
  gem 'cucumber-rails', :require => false


end
