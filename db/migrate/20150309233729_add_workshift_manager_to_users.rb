class AddWorkshiftManagerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :workshift_manager, :boolean
  end

  class AddAdminToUsers < ActiveRecord::Migration
    def self.up
      add_column :users, :workshift_manager, :boolean, :default => false
    end

    def self.down
      remove_column :users, :workshift_manager
    end
  end
end
