class AddWeeklyHoursAndHoursBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :weekly_hours, :integer, default: 0, null: false
    add_column :users, :hours_balance, :integer, default: 0, null: false
  end
end
