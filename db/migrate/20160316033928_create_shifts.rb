class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :metashift, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
