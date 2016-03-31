require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    describe "creating a new session by successfully logging in" do
        it 'should render the correct views' do
            get :new
            expect(response).to render_template(:application)
            expect(response).to render_template(:new)
        end
        it 'should find the user by the provided email' do
            expect(User).to receive("find_by_email").with('m@gmail.com')
            post :create, {:email => 'm@gmail.com', :password => '432jkfla'}
        end
    
    end
    
    describe "unsuccessful login attempt" do
        before(:each) do
            post :create, {:email => 'm@gmail.com', :password => '432jkfla'}
        end
        it 'should flash a message if login is incorrect' do
            expect(flash[:danger]).to be_present
        end
        it 'should refresh if login is incorrect' do
            expect(response).to redirect_to('/login')
        end
    end
    
    describe "destroying a user" do
        it 'should redirect to the login page' do
            get :destroy
            expect(response).to redirect_to('/login')
        end
        it 'should set the session to nil' do
            get :destroy
            expect(session[:user_id]).to be_nil
        end
    end
end