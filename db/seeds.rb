# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Unit.destroy_all
Policy.destroy_all
Metashift.destroy_all
Shift.destroy_all
User.destroy_all

units = [{:name => "Cloyne"}]

unit_instances = []
units.each do |unit|
    unit_instances <<    Unit.create!(unit) 
end

policies = [{:first_day => "01/01/2016",  :last_day => "May 17, 2016",
             :fine_amount => 30, :fine_days => "April 13, 2016",
             :market_sell_by => 3}]
           
policy_instances = []  
policies.each do |policy|
    new_policy = Policy.create!(policy) 
    new_policy.unit = unit_instances[0]
    policy_instances <<  new_policy
end

users = [{:first_name => 'admin', :last_name => 'Z', 
          :email => 'coop_admin@berkeley.edu', 
          :permissions => User::PERMISSION[:ws_manager],
          :password => 'admin', :has_confirmed => true,
          :hour_balance => 5, :fine_balance => 40},
          {:first_name => 'member', :last_name => 'A', 
          :email => 'coop_member@berkeley.edu', 
          :permissions => User::PERMISSION[:member],
          :password => 'member', :has_confirmed => true,
          :hour_balance => 2, :fine_balance => 10},
          {:first_name => 'manager', :last_name => 'S', 
          :email => 'coop_manager@berkeley.edu', 
          :permissions => User::PERMISSION[:manager],
          :password => 'manager', :has_confirmed => true,
          :hour_balance => 10, :fine_balance => 50}
    	  ]

metashifts = [{:category => 'Cooking', :description => 'fake description',
          :multiplier => 2.0},
          {:category => 'Cleaning', :description => 'fake description',
          :multiplier => 2.0},
          {:category => 'Trash Duty', :description => 'fake description',
          :multiplier => 2.0}]
          
user_instances = []
users.each do |user|
    new_user =  User.create!(user)
    new_user.unit = unit_instances[0]
    new_user.save
    user_instances <<    new_user
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