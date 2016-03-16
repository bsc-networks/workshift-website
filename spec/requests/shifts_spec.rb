require 'rails_helper'

RSpec.describe "Shifts", type: :request do
  describe "GET /shifts" do
    it "works! (now write some real specs)" do
      get shifts_path
      expect(response).to have_http_status(200)
    end
  end
end
