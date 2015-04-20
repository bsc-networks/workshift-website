class RemoveReportFromWeeklyReports < ActiveRecord::Migration
  def up
    remove_column :weekly_reports, :report
  end

  def down
    add_column :weekly_reports, :report, :text
  end
end
