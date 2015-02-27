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
30.times do
  name = Faker::Name.name
  email = "#{name.downcase.split.join('_')}@example.com"
  User.create(user_defaults.merge(email: email, name: name))
end
