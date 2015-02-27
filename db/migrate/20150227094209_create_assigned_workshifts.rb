class CreateAssignedWorkshifts < ActiveRecord::Migration
  def change
    create_table :assigned_workshifts do |t|
      t.references :workshift
      t.references :user

      t.timestamps
    end
    add_index :assigned_workshifts, :workshift_id
    add_index :assigned_workshifts, :user_id
  end
end
