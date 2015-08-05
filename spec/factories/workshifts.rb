require 'faker'

# == Schema Information
#
# Table name: workshifts
#
#  id            :integer          not null, primary key
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  start_time    :time
#  end_time      :time
#  day           :integer
#  description   :text
#  task          :string(255)
#  hours         :integer
#
FactoryGirl.define do
  factory :workshift do
    task { Faker::Company.bs.titleize }
    description { Faker::Hacker.say_something_smart }
    day { rand(7) }
    hours { rand(1..3) }
    start_time { Time.zone.parse('12:00pm') }
    end_time { start_time + 4.hours }
    user { nil }
    unit { Unit.find_or_create_by_name(name: 'Unit 1') }
  end
end
