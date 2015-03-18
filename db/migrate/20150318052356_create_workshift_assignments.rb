class CreateWorkshiftAssignments < ActiveRecord::Migration
  def change
    create_table :workshift_assignments do |t|
      t.string :task
      t.text :description
      t.time :start_time
      t.time :end_time
      t.date :date
      t.integer :hours
      t.text :notes
      t.datetime :sign_off_time
      t.string :status
      t.references :workshifter
      t.references :verifier
      t.references :workshift

      t.timestamps
    end
  end
end
