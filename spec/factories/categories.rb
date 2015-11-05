FactoryGirl.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:unit) { |n| Unit.find_or_create_by_name(name: 'Unit 1') }
  end
end
