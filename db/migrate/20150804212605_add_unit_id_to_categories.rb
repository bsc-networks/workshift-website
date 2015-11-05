class AddUnitIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :unit_id, :integer
  end
end
