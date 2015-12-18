class CreateDayQuietHours < ActiveRecord::Migration
  def change
    create_table :day_quiet_hours do |t|
      t.integer :quiet_hour_id
      t.time :start_time
      t.time :end_time
      t.string :day
    end
  end
end