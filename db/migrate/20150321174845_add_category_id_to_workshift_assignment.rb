class AddCategoryIdToWorkshiftAssignment < ActiveRecord::Migration
  def change
    add_column :workshift_assignments, :category_id, :integer
  end
end
