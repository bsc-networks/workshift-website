class AddUnitLevelAdminToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :unit_level_admin, :boolean, :null => false, :default => false
  end
end