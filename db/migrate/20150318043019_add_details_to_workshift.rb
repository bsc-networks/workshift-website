class AddDetailsToWorkshift < ActiveRecord::Migration
  def change
    change_table :workshifts do |t|
      t.remove :people_needed, :assigned_workshift
    end
  end
end
