Then(/^([^"]*)'s shift for "([^"]*)" on "([^"]*)" should be completed$/) do |first_name, metashift_name, date|
  user = User.find_by_first_name(first_name)
  metashift = Metashift.find_by_name(name)
  user.shifts.each do |shift|
      if shift.metashift == metashift and shift.date == Date.parse(date)
          assert shift.completed == true
      end
  end
end