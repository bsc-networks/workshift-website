require 'rails_helper'

RSpec.describe UnitsController, :type => :controller do
  before :each do
    user = double('user', :admin => true)
    allow(user).to receive(:admin?) { true }
    sign_in(user)
  end

  describe 'GET index' do
    context 'when an authenticated user is logged in' do
      before :each do
        @created_units = create_list(:unit, rand(10..20))
      end

      it 'assigns @units to all units' do
        get :index
        expect(assigns(:units)).to match_array @created_units
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
    it 'assigns @unit to a new unit' do
      get :new
      expect(assigns(:unit).attributes).to match Unit.new.attributes
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template 'new'
    end
  end

  describe 'getting a specific unit' do
    context 'when an authenticated user is signed in' do
      before :each do
        @id = rand(1..100)
        @unit = create(:unit, id: @id)
      end

      describe 'GET show' do
        it 'gets unit using id' do
          get :show, id: @id
          expect(assigns(:unit)).to eq @unit
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
        @unit = create(:unit, id: @id)
        sign_in double('user', :admin? => true)
      end

      describe 'GET edit' do
        it 'gets member using id' do
          get :edit, id: @id
          expect(assigns(:unit)).to eq @unit
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
        create(:unit, id: @id)
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
      it 'adds a new unit with the given parameters to the database' do
        attributes = { name: 'Cleaning' }
        post :create, unit: attributes
        expect(assigns(:unit).name).to match attributes[:name]
      end
    end

    context 'not all required attributes are present or valid' do
      before :each do
        attributes = { }
        post :create, unit: attributes
      end

      it 'renders the new template' do
        expect(response).to render_template 'new'
      end

      it 'does not save the unit to the database' do
        expect(Unit.first).to be_nil
      end
    end
  end

  describe 'DELETE destroy' do
    it 'removes a unit from the database' do
      create(:unit, id: 1, name: 'test')
      delete :destroy, id: 1
      expect(Unit.find_by_id(1)).to eq nil
    end
  end

end
