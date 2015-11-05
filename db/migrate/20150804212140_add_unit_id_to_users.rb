class AddUnitIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unit_id, :integer
  end
end
