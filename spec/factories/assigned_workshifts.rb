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
