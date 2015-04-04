Given /the following residents exist/ do |resident_table|
  resident_table.hashes.each do |resident|
    User.create!(resident)
  end
end



Then /I should see all the residents/ do
  numResidents = page.all('#residents tr').size - 1
  assert numResidents == 0
end	