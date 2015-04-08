Given /^no weekly reports exist$/ do
  WeeklyReport.delete_all
end
