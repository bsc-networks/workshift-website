class RemoveWeeklyHoursFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :weekly_hours
  end

  def down
    add_column :users, :weekly_hours, :integer
  end
end
