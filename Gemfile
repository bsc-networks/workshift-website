source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.19'

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # Enables Foundation framework
  gem 'modernizr-rails'
  gem 'foundation-rails', '~> 5.4.5.0'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

gem 'haml-rails', '~> 0.4.0'
gem 'redcarpet', '~> 3.0'

# Use Devise for authentification
gem 'devise'

gem 'simple_form'

gem 'faker'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails', '~> 2.14.0'
  gem 'simplecov'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end
# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
