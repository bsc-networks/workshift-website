class WeeklyReport < ActiveRecord::Base
  attr_accessible :report

  def title
    "weekly_resident_hours_#{date.gsub('/', '_')}.csv"
  end

  def date
    created_at.strftime('%m/%d/%y')
  end
end