class AddUserRefToWorkshifts < ActiveRecord::Migration
  def change
    change_table :workshifts do |t|
      t.references :user
    end
  end
end
