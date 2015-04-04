class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :rank
      t.references :category
      t.references :user
      t.timestamps
    end
  end
end
