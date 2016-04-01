class AddDefaultValueToHourBalance < ActiveRecord::Migration
  def change
    change_column :users, :hour_balance, :integer, :default => 0
    change_column :users, :fine_balance, :integer, :default => 0
  end
end
