class RemoveBadrefsFromunits < ActiveRecord::Migration
  def change
    remove_reference :units, :user, index: true, foreign_key: true
    remove_reference :units, :policy, index: true, foreign_key: true
  end
end
