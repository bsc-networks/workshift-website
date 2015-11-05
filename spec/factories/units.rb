FactoryGirl.define do
  factory :unit do
    sequence(:name) { |n| "Unit #{n}" }
  end

end
