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

  describe 'POST update_unit' do
    before :each do
      @admin = create(:user, unit: Unit.find_or_create_by_name(name: 'Unit 1'))
      @admin.update_attribute :unit_level_admin, true
      sign_in @admin
      @unit1 = Unit.find_or_create_by_name(name: 'Unit 1')
      @unit2 = Unit.find_or_create_by_name(name: 'Unit 2')
      @user = create(:user, unit: @unit1)
      @preference = create(:preference, user: @user, category_id: 1, rank: 1)
      @workshift = create(:workshift, user: @user, unit: @unit1)
      @workshift_assignment = create(:workshift_assignment, id: 2, workshifter: @user)
    end

    it 'removes preferences from user' do
      expect(@user.preferences.first).to eq(@preference)
      post :update_unit, unit: 'Unit 2', id: @user.id
      expect(@user.preferences.empty?).to be(true)
    end

    it 'unassociates workshifts, assignments but does not remove them from the old unit' do
      expect(@user.workshifts.first).to eq(@workshift)
      expect(@user.workshift_assignments.first).to eq(@workshift_assignment)
      post :update_unit, unit: 'Unit 2', id: @user.id
      expect(@user.workshifts.empty?).to eq(true)
      expect(@user.workshift_assignments.empty?).to eq(true)
      expect(@unit1.workshifts).to include(@workshift)
      expect(@unit1.workshift_assignments).to include(@workshift_assignment)
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
