class AddConfirmationInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sent_confirmation, :boolean, default: :false
    add_column :users, :has_confirmed, :boolean, default: :false
  end
end
