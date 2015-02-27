class AddStartTimeAndEndTimeToWorkshifts < ActiveRecord::Migration
  def change
    add_column :workshifts, :start_time, :time
    add_column :workshifts, :end_time, :time
  end
end
