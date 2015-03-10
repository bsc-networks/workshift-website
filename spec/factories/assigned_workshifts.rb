# == Schema Information
#
# Table name: assigned_workshifts
#
#  id           :integer          not null, primary key
#  workshift_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  completed    :boolean          default(FALSE)
#
FactoryGirl.define do
  factory :assigned_workshift do |f|
    sequence(:user_id)
    sequence(:workshift_id)
    f.completed { false }

    after :build do |assigned_workshift|
      workshift_id = assigned_workshift.workshift_id
      if Workshift.find_by_id(workshift_id).nil?
        create(:workshift, id: workshift_id)
      end
    end
  end
end
