class CreateMetashifts < ActiveRecord::Migration
  def change
    create_table :metashifts do |t|
      t.string :category
      t.string :description
      t.float :multiplier

      t.timestamps null: false
    end
  end
end
