class AddRequiredHoursToUsers < ActiveRecord::Migration
  def change
    add_column :users, :required_hours, :float, default: 5
  end
end
