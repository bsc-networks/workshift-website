require 'rails_helper'

RSpec.describe PoliciesController, type: :controller do
    describe "creting a semester policy" do 
        context "when I am an admin" do
            it "should select the New Policy template for rendering"
        end
        context "when I am a member" do
            it "should redirect to the home page" do
            end
        end
    end
    describe "loading the semester policies page" do
        context "when the policies for the semester have not been set" do
            context "when I am an admin" do
                it "should redirect to the set semester policies page"
            end
            context "when I am not an admin" do
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
        end
        context "when I am a member" do
            it "should redirect to the home page" do
            end
        end
    end
end