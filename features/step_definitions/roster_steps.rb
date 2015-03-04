Given /the following residents exist/ do |resident_table|
  resident_table.hashes.each do |resident|
    User.create(resident)
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  index1 = page.body.index(e1)
  index2 = page.body.index(e2)
  assert(index1 < index2, "not alphabetical")
end

Then /I should see all the residents/ do
  numResidents = page.all('#residents tr').size - 1
  assert numResidents == 0
end	