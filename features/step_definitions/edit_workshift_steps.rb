#Scenario 1
When /I click on "Edit" for the task "(.*)"/ do |task|
  find(:xpath, "//tr[td[contains(.,'#{task}')]]/td/a", :text => 'Edit').click
end

Then /I should be on the edit page for "(.*)"/ do

end

#Scenario 2, 3
Given /I am on the edit page for "(.*)"/ do |task|

end

When /I fill in:/ do |form_table|

end

When /I click on the "(.*)" button/ do |b|

end

Then /I should see:/ do |form_table|

end

Then /I should see an error page: "Invalid Fields"/ do

end

