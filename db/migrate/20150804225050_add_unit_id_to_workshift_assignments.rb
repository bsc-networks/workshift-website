class AddUnitIdToWorkshiftAssignments < ActiveRecord::Migration
  def change
    add_column :workshift_assignments, :unit_id, :integer
  end
end
