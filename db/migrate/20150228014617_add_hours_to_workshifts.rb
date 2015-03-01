class AddHoursToWorkshifts < ActiveRecord::Migration
  def change
    add_column :workshifts, :hours, :integer
  end
end
