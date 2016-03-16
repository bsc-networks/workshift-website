require "rails_helper"

RSpec.describe MetashiftsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/metashifts").to route_to("metashifts#index")
    end

    it "routes to #new" do
      expect(:get => "/metashifts/new").to route_to("metashifts#new")
    end

    it "routes to #show" do
      expect(:get => "/metashifts/1").to route_to("metashifts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/metashifts/1/edit").to route_to("metashifts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/metashifts").to route_to("metashifts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/metashifts/1").to route_to("metashifts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/metashifts/1").to route_to("metashifts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/metashifts/1").to route_to("metashifts#destroy", :id => "1")
    end

  end
end
