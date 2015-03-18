require 'faker'
# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the
# db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user_defaults = { password: 'secret', password_confirmation: 'secret' }
User.create!(user_defaults.merge(email: 'john@example.com', name: 'John Doe'))
User.create!(user_defaults.merge(email: 'sally@example.com',
                                 name: 'Sally Smith'))
manager = User.create!(user_defaults.merge(email: 'manager@example.com',
                                           name: 'Boss Man'))
manager.update_attribute :workshift_manager, true

30.times do
  name = Faker::Name.name
  email = "#{name.downcase.split.join('_')}@example.com"
  User.create(user_defaults.merge(email: email, name: name))
end

7.times do |day|
  10.times do
    start_time = Faker::Time.forward(10, :all).change(min: 0)
    end_time = start_time + 4.hours
    hours = rand(3) + 1
    task = Faker::Company.bs.titleize
    description = Faker::Hacker.say_something_smart
    # people_needed = rand(4) + 1
    Workshift.create(day: day, start_time: start_time, end_time: end_time,
                     hours: hours, task: task, description: description)
  end
end
