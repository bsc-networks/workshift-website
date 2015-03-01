Given /^I am not signed in$/ do
  current_driver = Capybara.current_driver
  begin
    Capybara.current_driver = :rack_test
    page.driver.submit :delete, "/users/sign_out", {}
  ensure
    Capybara.current_driver = current_driver
  end
end

When(/^I fill the following fields:$/) do |table|
  
  pending # express the regexp above with the code you wish you had
end
