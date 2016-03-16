require 'rails_helper'

RSpec.describe "Metashifts", type: :request do
  describe "GET /metashifts" do
    it "works! (now write some real specs)" do
      get metashifts_path
      expect(response).to have_http_status(200)
    end
  end
end
