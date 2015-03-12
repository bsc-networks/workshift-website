Given /^the following workshifts exist:$/ do |workshifts_table|
  workshifts_table.hashes.each do |workshift|

    #start_time = workshift["start_time"]
    #end_time = workshift["end_time"]
    #hours = workshift["hours"]
    #task = workshift["task"]
    #description = workshift["description"]
    #people_needed = workshift["people_needed"]
    #day = workshift["day"]
    #Workshift.create!(day: day, start_time: start_time, end_time: end_time,
                     #hours: hours, task: task, description: description,
                     #people_needed: people_needed)
    #puts workshift

    Workshift.create!(workshift)
  end
end

Then /^I should see all of the workshifts$/ do
  workshifts = Workshift.all
  num_workshifts = workshifts.length
  assert(num_workshifts != 0,
              "#{num_workshifts} workshifts exist.")
  within '#workshifts' do
    within 'tbody' do
      num_rows = all('tr').size
      assert(num_rows == num_workshifts,
             "#{num_rows} rows rendered, #{num_workshifts} workshifts exist.")
      workshifts.each do |workshift|
        assert page.has_content?(workshift.task)
      end
    end
  end
end

Then /I should be able to click on "(.*)" for the task "(.*)"/ do |action, task|
  assert find(:xpath, "//tr[td[contains(.,'#{task}')]]/td/a", :text => action).nil? == false, "Destroy option doesn't exist"
  find(:xpath, "//tr[td[contains(.,'#{task}')]]/td/a", :text => action).click
end
