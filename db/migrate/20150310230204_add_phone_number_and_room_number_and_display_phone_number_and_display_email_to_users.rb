class AddPhoneNumberAndRoomNumberAndDisplayPhoneNumberAndDisplayEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string, default: ''
    add_column :users, :room_number, :string, default: ''
    add_column :users, :display_phone_number, :boolean, default: false
    add_column :users, :display_email, :boolean, default: false
  end
end
