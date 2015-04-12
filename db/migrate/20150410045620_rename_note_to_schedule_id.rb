class RenameNoteToScheduleId < ActiveRecord::Migration
  def up
    rename_column :workshift_assignments, :notes, :schedule_id
  end

  def down
  end
end
