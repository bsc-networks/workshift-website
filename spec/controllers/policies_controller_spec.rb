require 'rails_helper'

RSpec.describe PoliciesController, type: :controller do
    before :each do
        @admin = User.create!(:id => 1, :first_name => 'Workshift', :last_name => 'Manager',
                :email => 'wsm@berkeley.edu', :password => 'admin', :permissions => User::PERMISSION[:ws_manager])
        @member = User.create!(:id => 2, :first_name => 'Regular', :last_name => 'Member',
                :email => 'rm@berkeley.edu', :password => 'member', :permissions => User::PERMISSION[:member])
    end
    describe "creating a semester policy" do 
        context "when the current user is an admin" do
            context "and no policy has been set" do
                before :each do
                    @new_policy = double("New Policy")
                    Policy.stub(:new).and_return(@new_policy)
                    Policy.stub(:create!).and_return(@new_policy)
                    request.session = { :user_id => @admin.id }
                    get :new
                end
                it "should select the New Policy template for rendering" do
                    expect(response).to render_template('new')
                end
                it "should initialize a policy object that is available to that template" do
                    expect(assigns(:policy)).to  eq(@new_policy)
                end
                it "should save the policy" do
                    expect(Policy).to receive(:create!)
                    post :create, policy: {id: 1}
                end
                it "should redirect to the view policy page" do
                    post :create, policy: {id: 1}
                    expect(response).to redirect_to(policy_path)
                end
            end
            context "and a policy has already been set" do
                it "should redirect to the edit policy page" do
                    
                    get :new
                    expect(response).to redirect_to(edit_policy_path)
                end
            end
        end
        context "when the current user is a member" do
            it "should redirect to the view policies" do
                request.session = { :user_id => @member.id }
                get :new
                expect(flash[:notice]).to be_present
                expect(response).to redirect_to(policy_path)
            end
        end
    end
    describe "loading the semester policies page" do
        context "when the policies for the semester have not been set" do
            before :each do
                @policies = double("All Policies", :last => nil)
                Policy.stub(:all).and_return(@policies)
            end
            context "and the current user is an admin" do
                it "should redirect to the set semester policies page" do
                    request.session = { :user_id => @admin.id }
                    get :show 
                    expect(response).to redirect_to(new_policy_path)
                end
            end
            context "and the current user is a member" do
                it "should redirect to the home page" do
                    request.session = { :user_id => @member.id }
                    get :show 
                    expect(flash[:info]).to be_present
                    expect(response).to redirect_to('/')
                end
            end
        end
        context "when the policies for the semester have been set" do
            before :each do
                @policy = double("Policy")
                @policies = double("All Policies", :last => @policy)
                Policy.stub(:all).and_return(@policies)
                request.session = { :user_id => @admin.id }
                get :show
            end
            it "should select the View Policy template for rendering" do
                expect(response).to render_template('show')
            end
            it "should make the correct policy available to that template" do
                expect(assigns(:policy)). to eq(@policy)
            end
        end
    end
    describe "editing the semester policies" do
        before :each do
            @policy = double("Policy")
            allow(@policy).to receive(:update_attributes!)
            @policies = double("All Policies", :last => @policy)
            Policy.stub(:all).and_return(@policies)
        end
        context "when the current user is an admin" do
            before :each do
                request.session = { :user_id => @admin.id }
                get :edit
            end
            it "should select the Edit Policy template for rendering" do
                expect(response).to render_template('edit')
            end
            it "should make the correct policy available to that template" do
                expect(assigns(:policy)).to eq(@policy)
            end
            it "should update the attributes of the policy" do
                expect(@policy).to receive(:update_attributes!)
                post :update, policy: {id: 1}
            end
            it "should redirect to the view policy page" do
                post :update, policy: {id: 1}
                expect(response).to redirect_to(policy_path)
            end
        end
        context "when the current user is a member" do
            it "should redirect to the view policy page" do
                request.session = { :user_id => @member.id }
                post :update, policy: {id: 1}
                expect(response).to redirect_to(policy_path)
            end
        end
    end
end