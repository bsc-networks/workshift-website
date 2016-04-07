class AddCompletedToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :completed, :boolean
  end
end
