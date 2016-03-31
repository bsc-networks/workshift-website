require 'rails_helper'

RSpec.describe PoliciesController, type: :controller do
    describe "creating a semester policy" do 
        context "when I am an admin" do
            it "should select the New Policy template for rendering"
            it "should initialize a policy object that is available to that template"
            it "should save the policy"
            it "should redirect to the view policy page"
        end
        context "when I am a member" do
            it "should redirect to the home page" do
            end
        end
    end
    describe "loading the semester policies page" do
        context "when the policies for the semester have not been set" do
            context "and I am an admin" do
                it "should redirect to the set semester policies page"
            end
            context "and I am not an admin" do
                it "should redirect to the policies have not been set page"
            end
        end
        context "when the policies for the semester have been set" do
            it "should select the View Policy template for rendering"
            it "should make the correct policy available to that template"
        end
    end
    describe "editing the semester policies" do
        context "when I am an admin" do
            it "should select the Edit Policy template for rendering"
            it "should make the correct policy available to that template"
            it "should update the attributes of the policy"
            it "should redirect to the view policy page"
        end
        context "when I am a member" do
            it "should redirect to the home page" do
            end
        end
    end
end