class WeeklyReport < ActiveRecord::Base
  belongs_to :unit

  attr_accessible :report, :unit

  def title
    "weekly_resident_hours_#{period.gsub('/', '_')}.csv"
  end

  def text(unit)
    report = ''
    CSV.generate(report) do |csv|
      User.where(unit_id: unit).each do |user|
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

  def self.semester_report(unit)
    report = ''
    CSV.generate(report) do |csv|
      User.where(unit_id: unit).each do |user|
        csv << [user.name, user.hours_balance]
      end
    end
    report
  end
end
