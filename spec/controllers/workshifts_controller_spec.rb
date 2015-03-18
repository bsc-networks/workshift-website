require 'rails_helper'

describe WorkshiftsController do
  before :each do
    user = double('user')
    allow(user).to receive(:workshift_manager?) { true }
    sign_in(user)
  end

  describe 'GET index' do
    context 'when an authenticated user is logged in' do
      before :each do
        @created_workshifts = create_list(:workshift, rand(10..20))
      end

      it 'assigns @workshifts to all workshifts' do
        get :index
        expect(assigns(:workshifts)).to match_array @created_workshifts
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template 'index'
      end
    end

    context 'when not authenticated' do
      it 'redirects you to the login page' do
        sign_in nil
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET new' do
    it 'assigns @workshift to a new workshift' do
      get :new
      expect(assigns(:workshift).attributes).to match Workshift.new.attributes
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe 'getting a specific workshift' do
    context 'when an authenticated user is signed in' do
      before :each do
        @id = rand(1..100)
        @workshift = create(:workshift, id: @id)
      end

      describe 'GET show' do
        it 'gets workshift using id' do
          get :show, id: @id
          expect(assigns(:workshift)).to eq @workshift
        end

        it 'renders the show template' do
          get :show, id: @id
          expect(response).to render_template 'show'
        end
      end
    end

    context 'when workshift manager is signed in' do 
      before :each do
        @id = rand(1..100)
        @workshift = create(:workshift, id: @id)
        sign_in double('user', :workshift_manager? => true)
      end

      describe 'GET edit' do
        it 'gets member using id' do
          get :edit, id: @id
          expect(assigns(:workshift)).to eq @workshift
        end

        it 'renders the edit template' do
          get :edit, id: @id
          expect(response).to render_template 'edit'
        end
      end
    end

    context 'when not authenticated' do
      before :each do
        @id = rand(1..100)
        create(:workshift, id: @id)
        sign_in nil
      end

      describe 'GET show' do
        it 'redirects to the login page' do
          get :show, id: @id
          expect(response).to redirect_to(new_user_session_path)
        end
      end

      describe 'GET edit' do
        it 'redirects to the login page' do
          get :edit, id: @id
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

  describe 'POST create' do
    context 'all required attributes are present and valid' do
      it 'adds a new workshift with the given parameters to the database' do
        start_time = Time.zone.parse('1:30pm')
        end_time = start_time + 3.hours
        attributes = { task: 'Wash dishes', description: 'dishes need washing',
                       hours: 1, start_time: start_time, end_time: end_time, day: 0 }
        post :create, workshift: attributes
        expect(assigns(:workshift).task).to match attributes[:task]
        expect(assigns(:workshift).description).to eq attributes[:description]
        expect(assigns(:workshift).hours).to eq attributes[:hours]
        expect(assigns(:workshift).day).to eq attributes[:day]
        expect(assigns(:workshift).start_time.hour).to eq start_time.hour
        expect(assigns(:workshift).start_time.min).to eq start_time.min
        expect(assigns(:workshift).end_time.hour).to eq end_time.hour
        expect(assigns(:workshift).end_time.min).to eq end_time.min
      end
    end

    context 'not all required attributes are present or valid' do
      before :each do
        start_time = Time.zone.parse('1:30pm')
        end_time = start_time + 3.hours
        attributes = { task: '', start_time: start_time, end_time: end_time }
        post :create, workshift: attributes
      end

      it 'renders the new template' do
        expect(response).to render_template 'new'
      end

      it 'does not save the workshift to the database' do
        expect(Workshift.first).to be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'removes a workshift from the database' do
      create(:workshift, id: 1)
      delete :destroy, id: 1
      expect(Workshift.find_by_id(1)).to eq nil
    end
  end

  describe 'PUT update' do
    it 'updates a workshifts parameters' do
      workshift = create(:workshift, id: 9999, task: 'Wash the dishes')
      put :update, id: 9999, workshift: { task: 'Wash dinner dishes' }
      workshift.reload
      expect(workshift.task).to eq 'Wash dinner dishes'
    end
  end
end
