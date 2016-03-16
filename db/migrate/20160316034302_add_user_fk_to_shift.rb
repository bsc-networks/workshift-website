class AddUserFkToShift < ActiveRecord::Migration
  def change
    add_reference :shifts, :user, index: true
    add_foreign_key :shifts, :users
  end
end
