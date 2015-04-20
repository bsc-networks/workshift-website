class WeeklyReport < ActiveRecord::Base
  attr_accessible :report

  def title
    "weekly_resident_hours_#{date.gsub('/', '_')}.csv"
  end

  def text
    report = ''
    CSV.generate(report) do |csv|
      # User.all.each do |user|
      #   csv << [user.name, user.weekly_hours]
      # end
    end
    report
  end

  def date
    created_at.strftime('%m/%d/%y')
  end
end
