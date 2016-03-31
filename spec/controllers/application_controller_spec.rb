require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    before(:each) do
        @controller = ApplicationController.new
        @a_user = User.create!(:first_name => 'my user', :last_name => 'last',
            :email => 'auser@gmail.com', :password => '3ljkd;a2', :permissions =>
            User::PERMISSION[:member])
        @user = User.find_by(:first_name => 'my user')
        request.session = { :user_id => @user.id }
    end
    
    describe "checks unit information" do
        it 'checks the current house' do
            house = @controller.instance_eval{ current_house }
            expect(house).to eq("Cloyne")
        end
    end
    
    # describe "it keeps track of the current user" do
    #     it "finds the current user" do
    #         expect(User).to receive("find")
    #         @controller.instance_eval { current_user } 
    #         expect(session[:user_id]).to be_truthy
    #     end
    # end
end