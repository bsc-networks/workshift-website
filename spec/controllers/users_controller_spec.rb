require 'rails_helper'

describe UsersController do
  describe 'GET index' do
    context 'when an authenticated user is logged in' do
      before :each do
        @created_users = create_list(:user, rand(10..20))
        @user = create(:user, :with_assigned_workshifts, id: 4242, unit: Unit.find_or_create_by_name(name: 'Unit 1'))
        sign_in @user
      end

      it 'assigns @users to all users' do
        get :index
        expect(assigns(:users)).to match_array @created_users + [@user]
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template 'index'
      end
    end
  end

  describe 'GET profile' do
    context 'when an authenticated user is logged in' do
      before :each do
        user = create(:user, :with_assigned_workshifts, id: 4243, unit: Unit.find_or_create_by_name(name: 'Unit 1'))
        sign_in user
      end

      # it 'assigns @workshifts_assignments to users workshift assignments' do
      #   get :profile, id: 1
      #   assignments = @user.workshift_assignments
      #   expect(assigns(:workshift_assignments)).to match_array assignments
      # end

      it 'renders the profile template' do
        get :profile, id: 4243
        expect(response).to render_template 'profile'
      end
    end
  end

  describe 'GET view_semester_report' do
    context 'an authenticated user is logged in' do
      it 'renders the view_semester_report template' do
        user = create(:workshift_manager, unit: Unit.find_or_create_by_name(name: 'Unit 1'))
        sign_in user
        get :view_semester_report
        expect(response).to render_template 'view_semester_report'
      end
    end
  end

  describe 'GET view_report' do
    context 'a workshift manager is signed in' do
      it 'renders the view_report template' do
        user = create(:workshift_manager, unit: Unit.find_or_create_by_name(name: 'Unit 1'))
        sign_in user
        create(:weekly_report, id: 1)
        get :view_report, id: 1
        expect(response).to render_template 'view_report'
      end
    end
  end
  #describe 'POST update_schedule' do
  #  context 'when an authenticated user is logged in'
  #  before :each do
  #    @user = create(:user, :with_assigned_workshifts, id: 1)
  #    sign_in
  #  end
  #  it 'renders the index template' do
  #    new_schedule = User.create_schedule
  #    post :update_schedule, id: 1, schedule: new_schedule
  #    expect(response).to render_template 'index'
  #  end
  #end
end
