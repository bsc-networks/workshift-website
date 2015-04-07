FactoryGirl.define do
  factory :preference do
    sequence(:rank) { |n| n }
    user_id 1
    category_id 1
  end
end
