require 'rails_helper'

RSpec.describe UsersController, type: :controller do
    before(:each) do
        @a_user = User.create!(:first_name => 'my user', :last_name => 'last',
            :email => 'auser@gmail.com', :password => '3ljkd;a2', :permissions =>
            User::PERMISSION[:member])
        @user = User.find_by(:first_name => 'my user')
        request.session = { :user_id => @user.id }
    end
    
    describe "creating users" do
        it 'should render the signup page' do
            get :new
            expect(response).to render_template(:new)
        end 
        
        describe "creating a user without password provided" do
            it 'should redirect to signup if user is missing a password' do
                post :create, :user => {:first_name => 'M',
                :last_name => 'F',
                :email => 'ehjd@gmail.com',
                :permissions => User::PERMISSION[:member]
                }
                expect(response).to redirect_to('/signup')
            end
        end
        
        describe "creating a user with password provided" do
            before(:each) do
                @my_user = {:first_name => 'M',
                :last_name => 'F',
                :email => 'ehjd@gmail.com',
                :permissions => User::PERMISSION[:member],
                :password => '48741fkdahl'
                }
            end
            
             it 'should redirect after successfully creating a user' do
                post :create, :user => @my_user
                expect(response).to redirect_to('/')
            end
            
            it 'should render the upload template after manually adding a user' do
                post :add_user, :user => @my_user
                expect(response).to render_template(:upload)
            end
        end
    end
    
    describe "uploading CSV file" do
        before(:each) do
            @file = fixture_file_upload('test.xml')
        end
        
        it 'should redirect if no file is provided' do
            post :upload
            expect(response).to redirect_to '/signup'
        end
        
        it 'should flash a message if no file is provided' do
            post :upload
            expect(flash[:notice]).to be_present
        end
        
        it 'should call a user method if a file is provided' do
            expect(User).to receive("import")
            User.stub(:import).and_return([@a_user])
            post :upload, :file => @file
        end
    end
    
    describe "sending confirmation emails" do
        it 'should call a method in the user model to confirm' do
            expect(User).to receive("send_confirmation")
            post :confirm_users, :confirmed_ids => [@user.id]
        end
        
        it 'should flash a message on success' do
            post :confirm_users, :confirmed_ids => [@user.id]
            expect(flash[:success]).to be_present
        end
        
        it 'should redirect to show all users' do
            post :confirm_users, :confirmed_ids => [@user.id]
            expect(response).to redirect_to '/users/get_all'
        end
    end
    
    describe 'getting all users for the table' do
        it 'should lookup each user by their id' do
            expect(User).to receive("find").with((@user.id).to_s)
            post :add_user, :user => {:first_name => 'M',
            :last_name => 'F',
            :email => 'ehjd@gmail.com',
            :permissions => User::PERMISSION[:member],
            :password => '48741fkdahl',
            }, :confirmed_ids => [@user.id]
        end
        it 'should render the data table' do
            get :get_all
            expect(response).to render_template(:get_all)
        end
    end
end