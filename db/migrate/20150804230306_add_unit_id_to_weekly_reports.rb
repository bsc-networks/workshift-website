class AddUnitIdToWeeklyReports < ActiveRecord::Migration
  def change
    add_column :weekly_reports, :unit_id, :integer
  end
end
