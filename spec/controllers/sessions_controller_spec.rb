require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
<<<<<<< HEAD
    before :each do
        @current_user = User.create!(:id => 2, :first_name => 'Regular', :last_name => 'Member',
                :email => 'rm@berkeley.edu', :password => 'member', :permissions => User::PERMISSION[:member])
        @current_user_pw = 'member'
    end
    describe "loading the login page" do
        context "when the current user is logged in" do 
            it "should redirect to the home page" do
                request.session[:user_id] = @current_user.id
                get :new
                expect(response).to redirect_to('/')
            end
        end
        context "when the current user is not logged in" do
            it "should select the Login template for rendering" do
                get :new
                expect(response).to render_template(:new)
            end
        end
    end
    describe "logging in a user" do
        before :each do
            User.stub(:find_by_email).and_return(@current_user)
        end
        it "should find the user in the database" do
            expect(User).to receive(:find_by_email)
            post :create, {:email => @current_user.email, :password => @current_user_pw}
            ### user needs to be @user in sessions_controller for this to work:  
                # assigns(:user).should == @current_user
                # expect(assigns(:user)).to == @current_user
        end
        it "should authenticate the user based on the password" do
            expect(@current_user).to receive(:authenticate)
            post :create, {:email => @current_user.email, :password => @current_user_pw}
        end
        context "when authentication succeeds" do
            before :each do
                @current_user.stub(:authenticate).and_return(true)
                post :create, {:email => @current_user.email, :password => @current_user_pw}
            end
            it "should set the session's current user" do
                expect(session[:user_id]).to be_present
            end
            it "should redirect to the home page" do
                expect(response).to redirect_to('/')
            end
        end
        context "when authentication fails" do
            it "should redirect to the login page" do
                @current_user.stub(:authenticate).and_return(false)
                post :create, {:email => @current_user.email, :password => @current_user_pw}
                expect(response).to redirect_to('/login')
            end
        end
    end
    describe "logging out a user" do
        before :each do
            get :destroy
        end
        it "should set the session's current user to nil" do
            expect(session[:user_id]).not_to be_present
        end
        it "should redirect to the login page" do
            expect(response).to redirect_to('/login')
        end
=======
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
>>>>>>> b785ed01dc7999ba4e70c22438b7e8edd3f6d93a
    end
end