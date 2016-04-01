require 'rails_helper'

RSpec.describe ShiftsController, type: :controller do
    before(:each) do 
        @user1 = create(:user, first_name: "Joe")
        @meta_shift = create(:metashift)
        @shift = create(:shift, metashift: @meta_shift, user: @user1)
        @shift.save
    end 
    
    describe "preparing a new shift" do
        before(:each) do
            get :new
        end
        it 'should provide a new form' do
            expect(response).to render_template(:new)
        end
        it 'should prepare a new instance of a shift' do
            get :new
            expect(assigns(:shift)).to be_a_new(Shift)
        end
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