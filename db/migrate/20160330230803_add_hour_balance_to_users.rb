class AddHourBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hour_balance, :integer
  end
end
