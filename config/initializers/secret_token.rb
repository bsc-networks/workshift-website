# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
if Rails.env.development? || Rails.env.test?
  token = 'x' * 50
else
  token = ENV['SECRET_TOKEN']
end
WorkshiftWebsite::Application.config.secret_token = token
