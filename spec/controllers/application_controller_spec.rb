require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    controller do
        def index 
            render :text => "Hello World"
        end
    end
    
    before :each do
        @current_user = double("Current User")
    end
    describe "checking that a user is logged in" do
        describe "getting the current user" do
            it "should use the session to find the current user" do
                allow(User).to receive(:find_by_id)
                
                expect(request.session).to receive(:[]).at_least(:once)
                expect(User).to receive(:find_by_id)
                get :index
            end
            context "when a user is logged in" do
                it "should make the current user available to the application" do
                    allow(User).to receive(:find_by_id).and_return(@current_user)
                    
                    get :index
                    expect(assigns(:current_user)).to eq(@current_user)
                end
            end
            context "when the user does not exist" do
                it "should remove the current user" do
                    allow(User).to receive(:find_by_id).and_return(nil)
                    
                    get :index
                    expect(assigns(:current_user)).to eq(nil)
                    # expect(assigns(session[:user_id])).to eq(nil)
                end
            end
        end
        describe "authorizing the session" do
            context "when no user is logged in" do
                it "should redirect to the login page" do
                    allow(User).to receive(:find_by_id).and_return(nil)
                    
                    get :index
                    expect(response).to redirect_to(login_path)
                end
            end
        end
    end
end