FactoryGirl.define do
  factory :workshift_assignment do
    association :workshifter, factory: :user
    workshift
    description { workshift.description }
    start_time { workshift.start_time }
    end_time { workshift.end_time }
    date do
      time = Faker::Time.forward(7, :all).beginning_of_day
      day_of_week = time.strftime("%w").to_i
      days_to_add = (workshift.day - day_of_week) % 7
      time += days_to_add.days
      time += workshift.start_time.hour
      time
    end
    hours { workshift.hours }
    task { workshift.task }
    status "Upcoming"
    purchased false
  end
end