Given /^I am logged in as an authenticated user$/ do
  email = 'test@example.com'
  password = 'secret'
  name = 'Test User'
  User.new(email: email, password: password, password_confirmation: password,
           name: name).save!
  visit login_path
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  click_button 'Sign In'
end
