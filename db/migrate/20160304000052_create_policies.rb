class CreatePolicies < ActiveRecord::Migration
  def change
    create_table :policies do |t|
      t.datetime :first_day
      t.datetime :last_day
      t.integer :fine_amount
      t.datetime :fine_days
      t.integer :market_sell_by

      t.timestamps null: false
    end
  end
end
