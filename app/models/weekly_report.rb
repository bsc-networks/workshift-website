class WeeklyReport < ActiveRecord::Base
  attr_accessible :report

  def title
    "weekly_resident_hours_#{date.gsub('/', '_')}.csv"
  end

  def self.create_weekly_report
    report = ''
    CSV.generate(report) do |csv|
      User.all.each do |user|
        csv << [user.name, user.weekly_hours]
      end
    end
    WeeklyReport.create(report: report)
  end

  def date
    created_at.strftime('%m/%d/%y')
  end
end
