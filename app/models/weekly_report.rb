class WeeklyReport < ActiveRecord::Base
  attr_accessible :report

  def title
    "weekly_resident_hours_#{period.gsub('/', '_')}.csv"
  end

  def text
    report = ''
    CSV.generate(report) do |csv|
      User.all.each do |user|
        hours = user.hours_for_week(created_at)
        csv << [user.name, hours]
      end
    end
    report
  end

  def period
    "#{start_date.strftime('%m/%d/%y')}-#{end_date.strftime('%m/%d/%y')}"
  end

  # a report starts on the Sunday of the week before
  def start_date
    created_at.monday - 1.week - 1.day
  end

  # a report ends on the Saturday of the week before
  def end_date
    (created_at - 1.week).sunday - 1.day
  end

  def self.semester_report
    report = ''
    CSV.generate(report) do |csv|
      User.all.each do |user|
        csv << [user.name, user.hours_balance]
      end
    end
    report
  end
end
