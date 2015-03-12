#Scenario 1
When /I click on "Edit" for the task "(.*)"/ do |task|
  find(:xpath, "//tr[td[contains(.,'#{task}')]]/td/a", :text => 'Edit').click
end

Then /the edit page for "(.*)" should load/ do |task|
  assert(page.has_content?("Editing workshift") == true, "on an edit page")
  assert(page.find_field('workshift_task').value == task, "task name is on the page")
end

#Scenario 2, 3
Given /the edit page for "(.*)" is loaded/ do |task|
  visit(workshifts_path)
  find(:xpath, "//tr[td[contains(.,'#{task}')]]/td/a", :text => 'Edit').click
end

When /I fill in:/ do |form_table|
  form_table.hashes.each do |entry|
    #puts entry
    mapping = {"Task"=>"workshift_task", 
          "NumberNeeded"=>"workshift_people_needed", 
          "Hours"=>"workshift_hours", 
          "StartTime"=>["workshift_start_time_4i", "workshift_start_time_5i"], 
          "EndTime"=>["workshift_end_time_4i", "workshift_end_time_5i"],
          "Description"=>"workshift_description",
          "Day"=>"workshift_day"}
    if entry["field"] == "Day" then
      select(entry["value"], :from => mapping[entry["field"]])
    elsif entry["field"] == "StartTime" or entry["field"] == "EndTime" then
      if entry["value"][1] == ":" then
        firstvalue = "0"+entry["value"][0] + " " + entry["value"][5..6]
        secondvalue = entry["value"][2..3]
      else
        firstvalue = entry["value"][0..1] + " " + entry["value"][6..7]
        secondvalue = entry["value"][3..4]
      end
      select(firstvalue, :from => mapping[entry["field"]][0])
      select(secondvalue, :from => mapping[entry["field"]][1])
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
      assert(page.has_content?(entry['value']) == true, "doesn't have content " + entry['value'])
  end
end

Then /I should see an error message: "(.*)"/ do |msg|
  assert(page.has_content?(msg) == true, "no indication of error")
end

