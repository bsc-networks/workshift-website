require 'rails_helper'

RSpec.describe WorkshiftAssignment, :type => :model do

  before(:each) do
    WorkshiftAssignment.send(:public, *WorkshiftAssignment.protected_instance_methods)  
    @assignment = create(:workshift_assignment)
    @user = create(:user)
  end

  it 'has a valid factory' do
    expect(create(:workshift_assignment)).to be_valid
  end

  it 'has same day of the week as parent workshift' do
    expect(@assignment.date.strftime("%w").to_i).to eq(@assignment.workshift.day)
  end

  it 'returns the correct workshifter hour balance messages' do
    
    @assignment.workshifter = @user

    @assignment.purchased = true
    @user.hours_balance = 4
    @assignment.hours = 2

    @assignment.status = "complete"
    @assignment.update_workshifter_hours_balance
    expect(@user.hours_balance).to eq(6)

    @user.hours_balance = 4
    @assignment.status = "blown"
    @assignment.update_workshifter_hours_balance
    expect(@user.hours_balance).to eq(0)

    @user.hours_balance = 4
    @assignment.status = "sold"
    @assignment.purchased = false
    @assignment.update_workshifter_hours_balance
    expect(@user.hours_balance).to eq(2)

    @user.hours_balance = 4
    @assignment.status = "missed"
    @assignment.update_workshifter_hours_balance
    expect(@user.hours_balance).to eq(2)

    @user.hours_balance = 4
    @assignment.status = "undefined"
    expect{@assignment.update_workshifter_hours_balance}.to raise_error 'Cannot update workshifter hours in current status.'
  end

  it 'checks off and verifies correctly' do
    another_user = create(:user)
    @assignment.workshift = create(:workshift)
    @assignment.check_off(another_user)
    expect(@assignment.verifier).to eq(another_user)
  end

end
