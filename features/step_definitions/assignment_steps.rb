When (/^I assign "(.+)" to the workshift "(.+)"$/) do |resident, task|
  @user = User.find_by_name resident
  workshift = Workshift.find_by_task(task)
  assignment = workshift.assign_worker(user.id)
end

When (/^I am assigned to the shift "([^"]+)"$/) do |shift|
  workshift = Workshift.find_by_task(shift)
  @assignment = workshift.assign_worker(@user)
end

When (/^my assignment has not started yet$/) do
  Timecop.freeze(@assignment.date - 1.day)
end

When (/^my assignment is awaiting check off$/) do
  shift_start_time = @assignment.begin_workshift_date + 10.minutes
  Timecop.travel(shift_start_time)
end

When (/^I check off my assignment as completed with verifier "(.+)"/) do |verifier_name|
  within("#assignment_#{@assignment.id}") do
    select(verifier_name, :from => "verifier_")
  end
  # page.find("#assignment_#{@assignment.id} select").select_option(verifier_name)
  click_button('Check Off')
end

When (/^my assignment should (?:still)? be "(.+)"/) do |status|
  expect(page.find("#assignment_#{@assignment.id}")).to have_text(status)
end