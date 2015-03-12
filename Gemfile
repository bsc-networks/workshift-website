source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.19'

gem 'jquery-rails'

gem 'haml-rails', '~> 0.4.0'
gem 'redcarpet',  '~> 3.0'

# Use Devise for authentification
gem 'devise'
gem 'pundit'
gem 'devise_invitable', '~> 1.3.4'

gem 'simple_form'

gem 'faker'

group :production do
  gem 'pg'
  gem 'rails_12factor'
  # Use unicorn as the app server
  gem 'unicorn'
end

group :development do
  gem 'annotate', '~> 2.6.5'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
end

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass',             '~> 3.2.5'
  gem 'sass-rails',       '~> 3.2.3'
  gem 'coffee-rails',     '~> 3.2.1'
  # Enables Foundation framework
  gem 'modernizr-rails'
  gem 'foundation-rails', '~> 5.4.5.0'
  gem 'uglifier',         '>= 1.0.3'
end
