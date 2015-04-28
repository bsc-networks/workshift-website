class ChangeHoursToFloats < ActiveRecord::Migration
  def up
    change_column :users, :hours_balance, :float
    change_column :workshift_assignments, :hours, :float
    change_column :workshifts, :hours, :float
  end

  def down
    change_column :users, :hours_balance, :integer
    change_column :workshift_assignments, :hours, :integer
    change_column :workshifts, :hours, :integer
  end
end
