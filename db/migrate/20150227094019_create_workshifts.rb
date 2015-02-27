class CreateWorkshifts < ActiveRecord::Migration
  def change
    create_table :workshifts do |t|

      t.timestamps
    end
  end
end
