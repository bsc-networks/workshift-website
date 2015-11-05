class AddUnitIdToWorkshifts < ActiveRecord::Migration
  def change
    add_column :workshifts, :unit_id, :integer
  end
end
