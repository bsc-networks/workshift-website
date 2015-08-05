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

# User Accounts

# Units

cloyne = Unit.create!(name: 'Cloyne')
tmp = Unit.create!(name: 'Tmp')

user_defaults = { password: 'secret', password_confirmation: 'secret' }
manager = User.create!(user_defaults.merge(email: 'manager@example.com',
                                           name: 'Boss Man',
                                           required_hours: 0))
manager.update_attribute :workshift_manager, true
manager.update_attribute :unit, cloyne

admin = User.create!(email: 'admin@example.com',
                     name: '42',
                     required_hours: 0,
                     password: 'C10H15N',
                     password: 'C10H15N',
                     unit: tmp)
admin.update_attribute :admin, true
admin.update_attribute :workshift_manager, true

User.create!(user_defaults.merge(email: 'john@example.com', name: 'John Doe', unit: cloyne))
User.create!(user_defaults.merge(email: 'sally@example.com',
                                 name: 'Sally Smith', unit: tmp))
30.times do
  name = Faker::Name.name
  email = "#{name.downcase.split.join('_')}@example.com"
  User.create(user_defaults.merge(email: email, name: name, unit: cloyne))
end

# Categories
category_dishes = Category.create!(name: 'Dishes', unit: cloyne)
User.create_preferences(category_dishes)
category_pots = Category.create!(name: 'Pots', unit: cloyne)
User.create_preferences(category_pots)
category_groceries = Category.create!(name: 'Groceries', unit: cloyne)
User.create_preferences(category_groceries)
category_cleaning = Category.create!(name: 'Cleaning', unit: cloyne)
User.create_preferences(category_cleaning)
category_cooking = Category.create!(name: 'Cooking', unit: cloyne)
User.create_preferences(category_cooking)
category_misc = Category.create!(name: 'Misc', unit: cloyne)
User.create_preferences(category_misc)

# Workshifts
7.times do |day|
  Workshift.create!(day: day, start_time: Time.parse('9:00AM'), hours: 1, unit:cloyne,
                    task: 'Wash breakfast dishes',
                    category_id: category_dishes.id,
                    end_time: Time.parse('1:00PM'),
                    description: 'Wash dirty dishes from breakfast.')
  Workshift.create!(day: day, hours: 1, unit:cloyne,
                    task: 'Wash dinner dishes',
                    category_id: category_dishes.id,
                    start_time: Time.parse('7:00PM'),
                    end_time: Time.parse('11:30PM'),
                    description: 'Wash dirty dishes from dinner.')
  Workshift.create!(day: day, hours: 1, unit:cloyne,
                    task: 'Wash dinner pots',
                    category_id: category_pots.id,
                    start_time: Time.parse('7:00PM'),
                    end_time: Time.parse('11:30PM'),
                    description: 'Wash the pots used to cook dinner')
  Workshift.create!(day: day, hours: 2, unit:cloyne,
                    task: 'Cook breakfast',
                    category_id: category_cooking.id,
                    start_time: Time.parse('6:00AM'),
                    end_time: Time.parse('9:30AM'),
                    description: 'Prepare breakfast for the house.')
  Workshift.create!(day: day, hours: 2, unit:cloyne,
                    task: 'Cook dinner',
                    category_id: category_cooking.id,
                    start_time: Time.parse('6:00PM'),
                    end_time: Time.parse('9:30PM'),
                    description: 'Prepare dinner for the house.')
end

Workshift.create!(day: 6, hours: 3, unit:cloyne,
                  task: 'Clean common room',
                  category_id: category_cleaning.id,
                  start_time: Time.parse('5:00AM'),
                  end_time: Time.parse('11:00PM'),
                  description: 'Dust, vacuum, and tidy up the common room.')
Workshift.create!(day: 6, hours: 3, unit:cloyne,
                  task: 'Get groceries',
                  category_id: category_groceries.id,
                  start_time: Time.parse('5:00AM'),
                  end_time: Time.parse('11:00PM'),
                  description: 'Go grocery shopping and restock the pantry.')
