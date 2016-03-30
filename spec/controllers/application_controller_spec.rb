require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    before(:each) do
        @controller = ApplicationController.new
    end
    describe "checks unit information" do
        it 'checks the current house' do
            house = @controller.instance_eval{ current_house }
            expect(house).to eq("Cloyne")
        end
    end
end