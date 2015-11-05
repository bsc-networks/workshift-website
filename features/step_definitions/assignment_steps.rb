When /^I assign "(.+)" to the workshift "(.+)"$/ do |resident, task|
  @user = User.find_by_name resident
  workshift = Workshift.find_by_task(task)
  @assignment = workshift.assign_worker(@user.id)
end

When /^I am assigned to the shift "([^"]+)"$/ do |task|
  @workshift = Workshift.find_by_task(task)
  if @workshift != nil
    @workshift.start_time = Time.zone.parse('10:00am')
    @workshift.end_time = Time.zone.parse('1:00pm')
  end
  @workshift ||= FactoryGirl.create(:workshift, task: task, unit: Unit.find_or_create_by_id(id: 1, name: 'Unit 1'))
  @assignment = @workshift.assign_worker(@user)
end

When /^my assignment has not started yet$/ do
  Timecop.freeze(@assignment.date - 1.day)
end

When /^my assignment is awaiting check off$/ do
  shift_start_time = @assignment.begin_workshift_date + 10.minutes
  Timecop.travel(shift_start_time)
  @assignment.status = 'awaiting check off'
  @assignment.save
end

When /^I check off my assignment as completed with verifier "(.+)"/ do |verifier|
  within("#assignment_#{@assignment.id}") do
    select(verifier, from: 'verifier_')
  end
  visit user_profile_path(@user)
  click_button('Check Off')
end

When /^my assignment should (?:still)? be "(.+)"/ do |status|
  expect(page.find("#assignment_#{@assignment.id}")).to have_text(status)
end
