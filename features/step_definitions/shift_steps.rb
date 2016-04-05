Then(/^([^"]*)'s shift for "([^"]*)" on "([^"]*)" should (not )?be completed$/) do |first_name, metashift_name, date, bool|
  user = User.find_by_first_name(first_name)
  metashift = Metashift.find_by_name(metashift_name)
  date = Date.parse(date)
  user.shifts.each do |shift|
    if shift.metashift == metashift and shift.date == date
      if bool
        assert shift.completed == false
      else
        assert shift.completed == true
      end
    end
  end
end
