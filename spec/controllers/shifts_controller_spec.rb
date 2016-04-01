require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
    before(:each) do 
        @user1 = create(:user, first_name: "Joe")
        @meta_shift = create(:metashift)
        @shift = create(:shift, metashift: @meta_shift, user: @user1)
        @shift.save
        puts @shift
    end 
    
    describe "Index" do
        it 'rand' do 
            get :index
        end
        
        # it 'should return something from shifts#index' do
        #     puts "Shifts"
        #     puts Shift.all
        #     puts "End shifts"
        #     get :index
        #     assigns(:shifts).should_not be_nil
        # end
    end
end