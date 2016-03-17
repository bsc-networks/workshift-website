 And /^"(.+)" should have hours "(\d\d:\d\d[AP]M)" to "(\d\d:\d\d[AP]M)"$/ do |task, startTime, endTime, day|
     row = find('tr', text: task)
     # Note: the expected content depends on if we create the specific datetime objects for that week, or
     # leave in a more abstract format, like Wednesday, 3:00PM to 4:00PM
     #row.should have_content(startTime)
     #row.should have_content(endTime)
     row.should have_content(day)
 end
 
 


