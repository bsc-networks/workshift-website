require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    describe "creating users" do
        before(:each) do
            @a_user = User.create!(:first_name => 'my user', :last_name => 'last',
            :email => 'auser@gmail.com', :password => '3ljkd;a2', :permissions =>
            User::PERMISSION[:member])
            @user = User.find_by(:first_name => 'my user')
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
            :password => '48741fkdahl'
            }
            expect(response).to redirect_to('/')
        end
        
        it 'should redirect to signup if user is missing a password' do
             post :create, :user => {:first_name => 'M',
                :last_name => 'F',
                :email => 'ehjd@gmail.com',
                :permissions => User::PERMISSION[:member]
            }
            expect(response).to redirect_to('/signup')
        end
        
        it 'should render the upload template after manually adding a user' do
            post :add_user, :user => {:first_name => 'M',
            :last_name => 'F',
            :email => 'ehjd@gmail.com',
            :permissions => User::PERMISSION[:member],
            :password => '48741fkdahl'
            }
            expect(response).to render_template(:upload)
        end
    end
end