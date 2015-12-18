class CreateQuietHours < ActiveRecord::Migration
  def change
  	create_table :quiet_hours do |t|
  		t.integer :unit_id
  	end
  end
end
