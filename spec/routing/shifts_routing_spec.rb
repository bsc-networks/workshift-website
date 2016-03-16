require "rails_helper"

RSpec.describe ShiftsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/shifts").to route_to("shifts#index")
    end

    it "routes to #new" do
      expect(:get => "/shifts/new").to route_to("shifts#new")
    end

    it "routes to #show" do
      expect(:get => "/shifts/1").to route_to("shifts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/shifts/1/edit").to route_to("shifts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/shifts").to route_to("shifts#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/shifts/1").to route_to("shifts#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/shifts/1").to route_to("shifts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/shifts/1").to route_to("shifts#destroy", :id => "1")
    end

  end
end
