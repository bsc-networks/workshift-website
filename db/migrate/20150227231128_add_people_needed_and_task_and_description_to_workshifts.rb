class AddPeopleNeededAndTaskAndDescriptionToWorkshifts < ActiveRecord::Migration
  def change
    add_column :workshifts, :people_needed, :integer
    add_column :workshifts, :description, :text
    add_column :workshifts, :task, :string
  end
end
