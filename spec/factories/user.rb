FactoryGirl.define do
    factory :user do
        first_name 'Default'
        last_name 'User'
        email 'default@gmail.com'
        permissions User::PERMISSION[:member]
        password 'password'
        id 0
    end
end