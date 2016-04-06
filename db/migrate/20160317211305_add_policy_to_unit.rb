class AddPolicyToUnit < ActiveRecord::Migration
  def change
    add_reference :units, :policy, index: true, foreign_key: true
  end
end
