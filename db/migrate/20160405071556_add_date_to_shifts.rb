class AddDateToShifts < ActiveRecord::Migration
  def change
    add_column :shifts, :date, :datetime
  end
end
