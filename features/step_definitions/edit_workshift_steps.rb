#Scenario 1
When /I click on "Edit" for the task "(.*)"/ do |task|
  find(:xpath, "//tr[td[contains(.,'#{task}')]]/td/a", :text => 'Edit').click
end

Then /the manager should be on the edit page for "(.*)"/ do |task|
  assert(page.has_content?("Editing workshift") == true, "on an edit page")
  assert(page.find_field('workshift_task').value == task, "task name is on the page")
end

#Scenario 2, 3
Given /the manager is on the edit page for "(.*)"/ do |task|
  visit(workshifts_path)
  find(:xpath, "//tr[td[contains(.,'#{task}')]]/td/a", :text => 'Edit').click
end

When /I fill in:/ do |form_table|
  form_table.hashes.each do |entry|
    mapping = {"Task"=>"workshift_task", 
          "NumberNeeded"=>"workshift_people_needed", 
          "Hours"=>"workshift_hours", 
          "StartTime"=>"workshift_start_time_4i", 
          "EndTime"=>"workshift_end_time_4i",
          "Description"=>"workshift_description"}
    if entry["field"] == "StartTime" or entry["field"] == "EndTime" then
      select(entry["value"], :from => mapping[entry["field"]])
    else
      fill_in mapping[entry["field"]], with: entry["value"]
    end
  end
end

When /I click on the "(.*)" button/ do |b|
  click_button(b)
end

Then /I should (?:|still )see:/ do |form_table|
  form_table.hashes.each do |entry|
    if entry["field"] == "StartTime" or entry["field"] == "EndTime" then
      if entry['value'][0] == '0' then
        formattedTime = entry['value'][1]+":00 "+entry['value'][3..4]
      else
        formattedTime = entry['value'][0..1]+":00 "+entry['value'][3..4]
      end
      #puts formattedTime
      assert(page.has_content?(formattedTime) == true, "incorrect time")
    else
      assert(page.has_content?(entry['value']) == true, "doesn't have content " + entry['value'])
    end
  end
end

Then /I should see an error message: "(.*)"/ do |msg|
  assert(page.has_content?(msg) == true, "no indication of error")
end

