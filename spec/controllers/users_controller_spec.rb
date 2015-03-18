require 'rails_helper'

describe UsersController do
  describe 'GET index' do
    context 'when an authenticated user is logged in' do
      before :each do
        @created_users = create_list(:user, rand(10..20))
        sign_in
      end

      it 'assigns @users to all users' do
        get :index
        expect(assigns(:users)).to match_array @created_users
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template 'index'
      end
    end
  end

  describe 'GET profile' do
    context 'when an authenticated user is logged in'
    before :each do
      @user = create(:user, :with_assigned_workshifts, id: 1)
      sign_in
    end
    
    it 'assigns @workshifts_assignments to users workshift assignments' do
      get :profile, id: 1
      assignments = @user.workshift_assignments
      expect(assigns(:workshift_assignments)).to match_array assignments
    end

    it 'renders the profile template' do
      get :profile, id: 1
      expect(response).to render_template 'profile'
    end
  end
end
