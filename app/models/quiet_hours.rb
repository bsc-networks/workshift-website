class Quiet_hours

  @@path = Dir.pwd + '/.quiet_hours'

  def initialize
    @start = ""
    @stop = ""
    if not File.exist? @@path
      system("echo '11:00pm' > #{@@path}")
      system("echo '9:00am' >> #{@@path}")
    end
  end

  def path
    @@path
  end

  def set_quiet_hours(start, stop)
    @start = start
    @stop = stop

    system("echo '#{start}' > #{@@path}")
    system("echo '#{stop}' >> #{@@path}")
  end

  def get_quiet_hours
    b = true
    File.open(@@path, "r") do |f|
      f.each_line do |line|
        if b
          @start = line
          b = false
        else
          @stop = line
        end
      end
    end
    [@start, @stop]
  end

  def get_quiet_hours_str
    hours = get_quiet_hours
    hours[0] + ' and ' + hours[1]
  end

end
