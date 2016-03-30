class AddFineBalanceToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fine_balance, :integer
  end
end
