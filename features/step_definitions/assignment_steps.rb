When (/^I assign "(.+)" to the workshift "(.+)"$/) do |resident, task|
  user = User.find_by_name resident
  workshift = Workshift.find_by_task(task)
  assignment = workshift.assign_worker(user.id)
end