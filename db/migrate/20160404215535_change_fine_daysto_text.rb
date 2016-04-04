class ChangeFineDaystoText < ActiveRecord::Migration
  def change
    change_column :policies, :fine_days, :text
  end
end
