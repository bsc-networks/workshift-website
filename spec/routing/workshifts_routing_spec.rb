require "rails_helper"

RSpec.describe WorkshiftsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/workshifts").to route_to("workshifts#index")
    end

    it "routes to #new" do
      expect(:get => "/workshifts/new").to route_to("workshifts#new")
    end

    it "routes to #show" do
      expect(:get => "/workshifts/1").to route_to("workshifts#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/workshifts/1/edit").to route_to("workshifts#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/workshifts").to route_to("workshifts#create")
    end

    it "routes to #update" do
      expect(:put => "/workshifts/1").to route_to("workshifts#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/workshifts/1").to route_to("workshifts#destroy", :id => "1")
    end

  end
end
