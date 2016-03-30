require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "creating users" do
        before(:each) do
            @user = User.find_by(:first_name => 'member')
            request.session = { :user_id => @user.id }
        end
        
        it 'should render the signup page' do
            get :new
            expect(response).to render_template(:new)
        end 

        it 'should redirect after successfully creating a user' do
            post :create, :user => {:first_name => 'M',
                :last_name => 'F',
                :email => 'ehjd@gmail.com',
                :permissions => User::PERMISSION[:member],
                :password => '48741fkdahl'}
            expect(response).to redirect_to('/')
        end
        
        it 'should redirect to signup if user is missing a password' do
             post :create, :user => {:first_name => 'M',
                :last_name => 'F',
                :email => 'ehjd@gmail.com',
                :permissions => User::PERMISSION[:member]}
            expect(response).to redirect_to('/signup')
        end
    end
end