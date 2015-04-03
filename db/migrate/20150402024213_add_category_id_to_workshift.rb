class AddCategoryIdToWorkshift < ActiveRecord::Migration
  def change
    add_column :workshifts, :category_id, :integer
  end
end
