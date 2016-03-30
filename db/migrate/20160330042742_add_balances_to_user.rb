class AddBalancesToUser < ActiveRecord::Migration
  def change
    add_column :users, :hour_balance, :float, default: 0
    add_column :users, :fine_balance, :float, default: 0
  end
end
