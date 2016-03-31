FactoryGirl.define do
    factory :shift do
        start_time Time.now
        end_time Time.now + 1.hour
    end
end