When /^I fill in:$/ do |form_table|
  form_table.hashes.each do |entry|
    mapping = { 'Task' => 'workshift_task',
                'NumberNeeded' => 'workshift_people_needed',
                'Hours' => 'workshift_hours',
                'StartTime' => 'workshift_start_time_4i',
                'EndTime' => 'workshift_end_time_4i',
                'Description' => 'workshift_description'
    }
    if entry['field'] == 'StartTime' || entry['field'] == 'EndTime'
      select(entry['value'], from: mapping[entry['field']])
    else
      fill_in mapping[entry['field']], with: entry['value']
    end
  end
end

Then /^I should (?:|still )see:$/ do |form_table|
  form_table.hashes.each do |entry|
    if entry['field'] == 'StartTime' || entry['field'] == 'EndTime'
      if entry['value'][0] == '0'
        formatted_time = "#{entry['value'][1]}:00 #{entry['value'][3..4]}"
      else
        formatted_time = "#{entry['value'][0..1]}:00 #{entry['value'][3..4]}"
      end
      assert(page.has_content?(formatted_time), 'incorrect time')
    else
      assert(page.has_content?(entry['value']),
             "doesn't have content #{entry['value']}")
    end
  end
end

Then /^I should see an error message: "(.*)"$/ do |msg|
  assert(page.has_content?(msg), 'no indication of error')
end
