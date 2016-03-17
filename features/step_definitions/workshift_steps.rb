 And /^"(.+)" should have day "(.+") with hours "(\d\d:\d\d[AP]M)" to "(\d\d:\d\d[AP]M)"$/ do |task, day, startTime, endTime|
     row = find('tr', text: task)
     # Note: the expected content depends on if we create the specific datetime objects for that week, or
     # leave in a more abstract format, like Wednesday, 3:00PM to 4:00PM
     row.should have_content(startTime)
     row.should have_content(endTime)
     row.should have_content(day)
     row.should have_content(category)
 end
 
  And /^"(.+)" should have category "(.+)" with hour value "(\d)"$/ do |task, category, hourValue|
     row = find('tr', text: task)
     row.should have_content(category)
     row.should have_content(hourValue)
 end
 
And /^I have created workshifts for the semester$/ do
    user_maura = User.create!(first_name: "Maura", last_name: "Fitz", email: "momo@berkeley.edu", password: "pw")
    sweep_kitchen = Metashift.create!(:category => 'Kitchen', :name => 'Sweep Floors', :hour_value => 1)
    clean_shower = Metashift.create!(:category => 'Bathroom', :name => 'Clean the shower', :hour_value => 1.5)
    Workshift.create!(:metashift => sweep_kitchen, :start_time => '01:00PM', :end_time => '03:00PM', :day_of_week => 'Wednesday',
        :members_assigned => [user_maura])
    Workshift.create!(:metashift => clean_shower, :start_time => '02:30PM', :end_time => '03:30PM', :day_of_week => 'Friday',
        :members_assigned => [])
end

And /^some workshifts have been created for the semester$/ do
    step "I have created workshifts for the semester"
end

And /^I should see "(.+)" in the row for "(.+)"$/ do |name, task|
    row = find('tr', text: task)
    row.should have_content(name)
end

And /^I follow edit for "(.*)"$/ do |text|
    within :xpath, "//table//tr[td[contains(.,\"#{text}\")]]" do
        click_link 'Edit'
    end
end
 
 


