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

metashifts = [{:category => 'Cooking', :description => 'fake description',
          :multiplier => 2.0},
          {:category => 'Cleaning', :description => 'fake description',
          :multiplier => 2.0},
          {:category => 'Trash Duty', :description => 'fake description',
          :multiplier => 2.0}]
          
user_instances = []
users.each do |user|
    user_instances <<    User.create!(user) 
end

metashift_instances = []
metashifts.each do |metashift|
    metashift_instances << Metashift.create!(metashift)
end



shifts = [{:start_time => DateTime.strptime("09/02/2009 17:00", "%m/%d/%Y %H:%M"),
           :end_time => DateTime.strptime("09/02/2009 19:00", "%m/%d/%Y %H:%M"),
           :user => user_instances[0], :metashift => metashift_instances[0]},
           {:start_time => DateTime.strptime("09/01/2009 17:00", "%m/%d/%Y %H:%M"),
           :end_time => DateTime.strptime("09/01/2009 19:00", "%m/%d/%Y %H:%M"),
           :user => user_instances[1], :metashift => metashift_instances[1]},
           {:start_time => DateTime.strptime("09/03/2009 17:00", "%m/%d/%Y %H:%M"),
           :end_time => DateTime.strptime("09/03/2009 19:00", "%m/%d/%Y %H:%M"),
           :user => user_instances[2], :metashift => metashift_instances[2]}
           ]
           
shifts.each do |shift|
          Shift.create!(shift)
end