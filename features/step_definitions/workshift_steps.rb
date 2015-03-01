Given /^the following workshifts exist:$/ do |workshifts_table|
  workshifts_table.hashes.each do |workshift|
    Workshift.create(workshift)
  end
end

Then /^I should see all of the workshifts$/ do
  workshifts = Workshift.all
  num_workshifts = workshifts.length
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
