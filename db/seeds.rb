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
User.create!(user_defaults.merge(email: 'bucky@example.com',
                                 name: 'Bucky Johnson'))
User.create!(user_defaults.merge(email: 'mary@example.com', name: 'Mary Sue'))
User.create!(user_defaults.merge(email: 'lee@example.com', name: 'Lee Scott'))
