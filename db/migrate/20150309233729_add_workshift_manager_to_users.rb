class AddWorkshiftManagerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :workshift_manager, :boolean, default: false
  end
end
