require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
    describe "creating a new session by logging in" do
        it 'should render the correct views' do
            get :new
            expect(response).to render_template(:application)
            expect(response).to render_template(:new)
        end
    end
end