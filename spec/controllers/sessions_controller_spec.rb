require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
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
        # context "when the current user is not logged in" do
        #     it "should select the Login template for rendering" do
        #         response.should render_template('new')
        #     end
        # end
    end
    describe "logging in a user" do
        before :each do
            User.stub(:find_by_email).and_return(@current_user)
        end
        it "should find the user in the database" do
            User.should_receive(:find_by_email)
            post :create, {:email => @current_user.email, :password => @current_user_pw}
            ### user needs to be @user in sessions_controller for this to work:  
                # assigns(:user).should == @current_user
        end
        it "should authenticate the user based on the password" do
            @current_user.should_receive(:authenticate)
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
    end
end