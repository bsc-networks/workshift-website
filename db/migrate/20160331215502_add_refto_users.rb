class AddReftoUsers < ActiveRecord::Migration
  def change
    add_reference :users, :unit, foreign_key: true
    add_reference :policies, :unit, foreign_key: true
  end
end
