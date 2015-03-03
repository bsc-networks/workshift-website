require 'rails_helper'

describe WorkshiftsController do
  describe 'GET index' do
    context 'when an authenticated user is logged in' do
      before :each do
        @created_workshifts = create_list(:workshift, rand(10..20))
        sign_in
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

  describe 'getting a specific workshift' do
    context 'when an authenticated user is signed in' do
      before :each do
        @id = rand(1..100)
        @workshift = create(:workshift, id: @id)
        sign_in
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
end
