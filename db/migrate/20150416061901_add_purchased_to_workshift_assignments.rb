class AddPurchasedToWorkshiftAssignments < ActiveRecord::Migration
  def change
    add_column :workshift_assignments, :purchased, :boolean, default: false
  end
end
