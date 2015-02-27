require "spec_helper"

describe WorkshiftsController do
  describe "routing" do

    it "routes to #index" do
      get("/workshifts").should route_to("workshifts#index")
    end

    it "routes to #new" do
      get("/workshifts/new").should route_to("workshifts#new")
    end

    it "routes to #show" do
      get("/workshifts/1").should route_to("workshifts#show", :id => "1")
    end

    it "routes to #edit" do
      get("/workshifts/1/edit").should route_to("workshifts#edit", :id => "1")
    end

    it "routes to #create" do
      post("/workshifts").should route_to("workshifts#create")
    end

    it "routes to #update" do
      put("/workshifts/1").should route_to("workshifts#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/workshifts/1").should route_to("workshifts#destroy", :id => "1")
    end

  end
end
