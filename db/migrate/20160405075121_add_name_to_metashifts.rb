class AddNameToMetashifts < ActiveRecord::Migration
  def change
    add_column :metashifts, :name, :string
  end
end
