When (/^I assign "(.+)" to the workshift "(.+)"$/) do |resident, task|
  user = User.find_by_name resident
  workshift = Workshift.find_by_task(task)
  assignment = workshift.assign_worker(user.id)
end

When (/^I am assigned to the shift "(.+)"$/) do |shift|
  workshift = Workshift.find_by_task(shift)
  workshift.assign_worker(@user)
end