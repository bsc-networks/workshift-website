require 'rails_helper'

RSpec.describe AssignedWorkshift, type: :model do
  it 'has a valid factory' do
    expect(create(:assigned_workshift)).to be_valid
  end

  it 'is invalid without an integer user_id greater than 0' do
    expect(build(:assigned_workshift, user_id: nil)).to_not be_valid
    expect(build(:assigned_workshift, user_id: 0)).to_not be_valid
    expect(build(:assigned_workshift, user_id: 1)).to be_valid
    expect(build(:assigned_workshift, user_id: 1.1)).to_not be_valid
  end

  it 'is invalid without a workshift_id' do
    expect(build(:assigned_workshift, workshift_id: nil)).to_not be_valid
    expect(build(:assigned_workshift, workshift_id: 0)).to_not be_valid
    expect(build(:assigned_workshift, workshift_id: 1)).to be_valid
    expect(build(:assigned_workshift, workshift_id: 1.1)).to_not be_valid
  end
end
