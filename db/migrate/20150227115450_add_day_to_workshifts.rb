class AddDayToWorkshifts < ActiveRecord::Migration
  def change
    add_column :workshifts, :day, :integer
  end
end
