Given /^no weekly reports exist$/ do
  WeeklyReport.delete_all
end

When /^a new weekly report is generated$/ do
  @report = WeeklyReport.create_weekly_report
end

Then /^the title of the report contains today's date$/ do
  expect(@report.title).to include Time.now.strftime('%m_%d_%y')
end

Given /^"(.+)" is (down|up) (\d+) hours this week$/ do |user, sign, hours|
  hours = hours.to_i
  hours *= -1 if sign == 'down'
  user = User.find_by_name(user)
  user.weekly_hours = hours
  user.save
end

Then /^the report contains the entry "(.+)"$/ do |line|
  step 'I am on the view report page'
  expect(page).to have_content(line)
end

Then /^I can download the weekly report$/ do
  click_link 'Download'
  header = page.driver.response.headers
  expect(header['Content-Disposition']).to include "filename=#{@report.title}"
end
