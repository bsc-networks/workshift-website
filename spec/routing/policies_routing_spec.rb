require "rails_helper"

RSpec.describe PoliciesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/policies").to route_to("policies#index")
    end

    it "routes to #new" do
      expect(:get => "/policies/new").to route_to("policies#new")
    end

    it "routes to #show" do
      expect(:get => "/policies/1").to route_to("policies#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/policies/1/edit").to route_to("policies#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/policies").to route_to("policies#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/policies/1").to route_to("policies#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/policies/1").to route_to("policies#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/policies/1").to route_to("policies#destroy", :id => "1")
    end

  end
end
