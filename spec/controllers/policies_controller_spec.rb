require 'rails_helper'

RSpec.describe PoliciesController, type: :controller do
    before :each do
        @unit = double("Cloyne")
        @policy = double("Policy")
        @admin = double("Admin", :unit => @unit, :is_ws_manager? => true)
        @member = double("Member", :unit => @unit, :is_ws_manager? => false)
    end
    describe "creating a semester policy" do 
        context "when the current user is an admin" do
            before :each do
                allow(User).to receive(:find_by_id).and_return(@admin)
            end
            context "and no policy has been set" do
                before :each do
                    allow(@unit).to receive(:policy).and_return(nil)
                    
                    allow(Policy).to receive(:new).and_return(@policy)
                    allow(Policy).to receive(:create!).and_return(@policy)
                    allow(@unit).to receive(:save)
                    allow(@unit).to receive(:policy=)
                    
                    get :new
                end
                it "should select the New Policy template for rendering" do
                    expect(response).to render_template('new')
                end
                it "should initialize a policy object that is available to that template" do
                    expect(assigns(:policy)).to eq(@policy)
                end
                it "should save the policy and assign to the current user's unit" do
                    expect(Policy).to receive(:create!)
                    expect(@unit).to receive(:policy=)
                    post :create, { "policy"=>{"first_day"=>"2016-04-28", "last_day"=>"2016-06-13", 
                        "fine_days"=>"April 12, 2016; April 13, 2016", "fine_amount"=>"30", "market_sell_by"=>"3"}}
                end
                it "should redirect to the view policy page" do
                    post :create,  { "policy"=>{"first_day"=>"2016-04-28", "last_day"=>"2016-06-13", 
                        "fine_days"=>"April 12, 2016; April 13, 2016", "fine_amount"=>"30", "market_sell_by"=>"3"}}
                    expect(response).to redirect_to(policy_path)
                end
            end
            context "and a policy has already been set" do
                it "should redirect to the edit policy page" do
                    allow(@unit).to receive(:policy).and_return(@policy)
                    get :new
                    expect(response).to redirect_to(edit_policy_path)
                end
            end
        end
        context "when the current user is a member" do
            it "should redirect to the view policies" do
                allow(User).to receive(:find_by_id).and_return(@member)
                get :new
                expect(flash[:notice]).to be_present
                expect(response).to redirect_to(policy_path)
            end
        end
    end
    describe "loading the semester policies page" do
        context "when the policies for the semester have not been set" do
            before :each do
                allow(@unit).to receive(:policy).and_return(nil)
            end
            context "and the current user is an admin" do
                it "should redirect to the set semester policies page" do
                    allow(User).to receive(:find_by_id).and_return(@admin)
                    get :show 
                    expect(response).to redirect_to(new_policy_path)
                end
            end
            context "and the current user is a member" do
                it "should redirect to the home page" do
                    allow(User).to receive(:find_by_id).and_return(@member)
                    get :show 
                    expect(flash[:info]).to be_present
                    expect(response).to redirect_to('/')
                end
            end
        end
        context "when the policies for the semester have been set" do
            before :each do
                allow(@unit).to receive(:policy).and_return(@policy)
                allow(User).to receive(:find_by_id).and_return(@admin)
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
            allow(@policy).to receive(:update_attributes!)
        end
        context "when the current user is an admin" do
            before :each do
                allow(User).to receive(:find_by_id).and_return(@admin)
            end
            context "and no policy has been set" do
                it "should redirect to the set semester policies page" do
                    allow(@unit).to receive(:policy).and_return(nil)
                    get :edit
                    expect(response).to redirect_to(new_policy_path)
                end
            end
            context "and a policy has already been set" do
                before :each do
                    allow(@unit).to receive(:policy).and_return(@policy)
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
                    post :update, { "policy"=>{"first_day"=>"2016-04-28", "last_day"=>"2016-06-13", 
                        "fine_days"=>"April 12, 2016; April 13, 2016", "fine_amount"=>"30", "market_sell_by"=>"3"}}
                end
                it "should redirect to the view policy page" do
                    post :update, { "policy"=>{"first_day"=>"2016-04-28", "last_day"=>"2016-06-13", "fine_days"=>"April 12, 2016; April 13, 2016", "fine_amount"=>"30", "market_sell_by"=>"3"}}
                    expect(response).to redirect_to(policy_path)
                end
            end
        end
        context "when the current user is a member" do
            it "should redirect to the view policy page" do
                allow(User).to receive(:find_by_id).and_return(@member)
                allow(@unit).to receive(:policy).and_return(@policy)
                post :update,  { "policy"=>{"first_day"=>"2016-04-28", "last_day"=>"2016-06-13", 
                        "fine_days"=>"April 12, 2016; April 13, 2016", "fine_amount"=>"30", "market_sell_by"=>"3"}}
                expect(response).to redirect_to(policy_path)
            end
        end
    end
end
