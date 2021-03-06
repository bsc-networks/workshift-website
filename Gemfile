source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails'

# Use Postgres as database
gem 'pg'

gem 'jquery-rails'
gem 'jquery-ui-rails'

gem 'haml-rails', '~> 0.4.0'
gem 'redcarpet',  '~> 3.0'

# Use Devise for authentification
gem 'devise'
gem 'pundit'
gem 'devise_invitable', '~> 1.3.4'
# Use the DataTables jQuey plug-in for sortable, beautiful tables
gem 'jquery-datatables-rails', '~> 3.2.0'

gem 'simple_form'
gem 'chronic' # for natural language date/time parsing
gem 'rufus-scheduler'
gem 'faker'
gem 'clockwork'

# Stuff for Javascript
gem 'execjs'
#gem 'therubyracer' Causes install error on last mac version, do not seem to be used (Due to project update)

# Environment variable management
gem 'figaro'

gem 'exception_notification'

group :production do
  gem 'rails_12factor'
  # Use unicorn as the app server
  gem 'unicorn'
end

group :development do
  gem 'pry-rails'
  gem 'annotate', '~> 2.6.5'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-commands-cucumber'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'timecop'
  gem 'test-unit', '~> 3.0'
  # gem 'debugger' TODO Replace with a Ruby 2+ compatible gem (Due to project update)
  gem 'email_spec'
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
