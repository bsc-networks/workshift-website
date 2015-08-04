class CreateWorkshiftSellingLimit < ActiveRecord::Migration
  def change
    create_table :workshift_selling_limits do |t|
      t.integer :time_limit
    end
  end
end
