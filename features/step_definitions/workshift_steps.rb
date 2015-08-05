Given /^the following workshifts exist:$/ do |workshifts_table|
  workshifts_table.hashes.each do |workshift|
    w = Workshift.create!(workshift)
    w.update_attribute :unit, Unit.find_or_create_by_id(id: 1, name: 'Unit 1')
    w.save()
  end
end

Given /^the (?:|work)shift "(.+)" exists$/ do |task|
  @workshift = FactoryGirl.create(:workshift, task: task, unit_id: Unit.find_or_create_by_id(id: 1, name: 'Unit 1'))
end

Given /^it belongs to the category "(.+)"$/ do |name|
  @workshift.category_id = Category.find_by_name(name).id
  @workshift.save
end

Then /^I should see all of the workshifts$/ do
  workshifts = Workshift.where(unit_id: 1)
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

Then /^the "(.+)" workshift should exist for the following days:$/ do |task, days|
  all_days = days.raw.map(&:first)
  all_days = all_days.map { |day| Date::DAYNAMES.index(day) }
  all_days.each do |day|
    workshift = Workshift.where(day: day, task: task)
    expect(workshift.length).to eq 1
  end
end

Then /^I should be able to click on "(.*)" for the task "(.*)"$/ do |action, task|
  assert find(:xpath, "//tr[td[contains(.,'#{task}')]]/td/a",
              text: action).nil? == false, "Destroy option doesn't exist"
  find(:xpath, "//tr[td[contains(.,'#{task}')]]/td/a", text: action).click
end
