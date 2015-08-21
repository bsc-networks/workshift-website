require 'rails_helper'

describe WorkshiftAssignmentsController do
  before :each do
    @user = create(:user, id: 1)
    allow(@user).to receive(:workshift_manager?) { true }
    sign_in(@user)
  end

  it 'doesnt check off if the assignment cant be checked off' do
    @workshift_assignment = create(:workshift_assignment,
                                   id: 1, workshifter: @user)
    allow(@workshift_assignment).to receive(:can_check_off?).and_return(false)
    post :check_off, id: 1
    expect(response).to redirect_to user_profile_path(@workshift_assignment.workshifter)
  end

  it 'doesnt check off if the verifier is the same user' do
    @workshift_assignment = create(:workshift_assignment,
                                   id: 1, workshifter: @user,
                                   status: 'awaiting check off')
    post :check_off, id: 1, verifier: 1
    expect(response).to redirect_to user_profile_path(@workshift_assignment.workshifter)
  end

  it 'successfully puts an assignment on the market' do
    @workshift_assignment = create(:workshift_assignment,
                                   id: 1, workshifter: @user,
                                   status: 'upcoming')
    post :put_on_market, id: 1
    expect(response).to redirect_to marketplace_path
  end

  it 'responds correctly if an assignment cannot be put on the market' do
    @workshift_assignment = create(:workshift_assignment,
                                   id: 1, workshifter: @user,
                                   status: 'awaiting check off')
    post :put_on_market, id: 1
    expect(response).to redirect_to user_profile_path(@workshift_assignment.workshifter)
  end

  it 'doesnt sell one if current user is unauthorized' do
    another_user = create(:user, id: 2, email: 'lol@lol.com')
    @workshift_assignment = create(:workshift_assignment,
                                   id: 1, workshifter: another_user,
                                   status: 'awaiting check off')
    post :sell_to, id: 1, buyer_id: 2
    expect(response).to redirect_to user_profile_path(@user)
  end
end
