require 'faker'

FactoryGirl.define do
  factory :workshift do
    task { Faker::Company.bs.titleize }
    description { Faker::Hacker.say_something_smart }
    day { rand(7) }
    hours { rand(1..3) }
    start_time { Faker::Time.forward(10, :all).change(min: 0) }
    end_time { start_time + 4.hours }
    people_needed { rand(1..4) }
  end
end
