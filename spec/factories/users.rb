# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default("")
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string(255)
#  invitation_token       :string(255)
#  invitation_created_at  :datetime
#  invitation_sent_at     :datetime
#  invitation_accepted_at :datetime
#  invitation_limit       :integer
#  invited_by_id          :integer
#  invited_by_type        :string(255)
#  invitations_count      :integer          default(0)
#  workshift_manager      :boolean
#  phone_number           :string(255)      default("")
#  room_number            :string(255)      default("")
#  display_phone_number   :boolean          default(FALSE)
#  display_email          :boolean          default(FALSE)
#

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "User ##{n}" }
    sequence(:email) { |n| "person#{n}@example.com" }
    phone_number '(012) 345-6789'
    room_number '14a'
    display_phone_number true
    display_email true
    workshift_manager false
    password 'secret'

    factory :workshift_manager do
      workshift_manager true
    end

    trait :with_assigned_workshifts do
      transient do
        number_of_assignments 5
      end
      after :create do |user, evaluator|
        FactoryGirl.create_list :workshift_assignment,
                                evaluator.number_of_assignments, workshifter: user
      end
    end
  end
end
