# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


users = [{:first_name => 'admin', :last_name => 'Z', 
          :email => 'coop_admin@berkeley.edu', 
          :permissions => User::PERMISSION[:ws_manager],
          :password => 'admin', :has_confirmed => true },
          {:first_name => 'member', :last_name => 'A', 
          :email => 'coop_member@berkeley.edu', 
          :permissions => User::PERMISSION[:member],
          :password => 'member', :has_confirmed => true },
          {:first_name => 'manager', :last_name => 'S', 
          :email => 'coop_manager@berkeley.edu', 
          :permissions => User::PERMISSION[:manager],
          :password => 'manager', :has_confirmed => true }
    	  ]

users.each do |user|
   User.create!(user) 
end