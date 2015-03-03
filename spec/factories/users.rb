FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User ##{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    password 'secret'

    trait :with_assigned_workshifts do
      transient do
        number_of_workshifts 5
      end
      after :create do |user, evaluator|
        FactoryGirl.create_list :assigned_workshift,
                                evaluator.number_of_workshifts, user: user
      end
    end
  end
end
