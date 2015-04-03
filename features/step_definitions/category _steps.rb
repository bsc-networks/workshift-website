Given /^the following categories exist:$/ do |categories_table|
  categories_table.hashes.each do |category|
    Category.create!(category)
  end
end

When /I fill in the following for a category:/ do |form_table|
  form_table.hashes.each do |entry|
    mapping = {'Name' => 'category_name'
    }
    if entry['field'] == 'Day' then
      select(entry['value'], from: mapping[entry['field']])
    elsif entry['field'] == 'StartTime' or entry['field'] == 'EndTime' then
      if entry['value'][1] == ':' then
        firstvalue = '0'+entry['value'][0] + ' ' + entry['value'][5..6]
        secondvalue = entry['value'][2..3]
      else
        firstvalue = entry['value'][0..1] + ' ' + entry['value'][6..7]
        secondvalue = entry['value'][3..4]
      end
      select(firstvalue, :from => mapping[entry['field']][0])
      select(secondvalue, :from => mapping[entry['field']][1])
    else
      fill_in mapping[entry['field']], with: entry['value']
    end
  end
end

Then /^I should (?:|still )see the following for a category:$/ do |form_table|
  form_table.hashes.each do |entry|
      assert(page.has_content?(entry['value']) == true, "doesn't have content " + entry['value'])
  end
end
