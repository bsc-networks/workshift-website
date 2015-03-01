class AddCompletedToAssignedWorkshifts < ActiveRecord::Migration
  def change
    add_column :assigned_workshifts, :completed, :boolean, default: false
  end
end
