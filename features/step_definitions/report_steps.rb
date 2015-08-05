Given /^no weekly reports exist$/ do
  WeeklyReport.delete_all
end

When /^a new weekly report is generated$/ do
  @report = WeeklyReport.create
end

Then /^I should see the reports title$/ do
  expect(page).to have_content @report.title
end

Given /^"(.+)" is (down|up) (\d+) hours$/ do |user, sign, hours|
  hours = hours.to_i
  hours *= -1 if sign == 'down'
  user = User.find_by_name(user)
  user.hours_balance = hours
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

Then /^I should see the text of that report$/ do
  CSV.parse(@report.text(0)) do |row| #Using 0 as unit_id
    expect(page).to have_content(row[0])
    expect(page).to have_content(row[1])
  end
end

Then /^I should get a download with the filename "(.+)"$/ do |filename|
  expect(page.driver.response.headers['Content-Disposition']).to include("filename=#{filename}")
end
