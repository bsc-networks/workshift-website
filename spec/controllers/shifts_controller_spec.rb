require 'rails_helper'
require "json"

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
        it 'should display as json correctly' do
            @shift.full_json
        end
    end
    
    describe 'preparing shift timeslots' do
        before(:each) do
            @a_user = User.create!(:first_name => 'my user', :last_name => 'last',
                :email => 'auser@gmail.com', :password => '3ljkd;a2', :permissions =>
                User::PERMISSION[:ws_manager])
            @user = User.find_by(:first_name => 'my user')
            request.session = { :user_id => @user.id }
            @shift1 = Shift.new
            @shift2 = Shift.create!(:start_time => DateTime.strptime("09/02/2009 17:00", "%m/%d/%Y %H:%M"),
                                    :end_time => DateTime.strptime("09/02/2009 19:00", "%m/%d/%Y %H:%M"),
                                    :metashift_id => '')
        end

        it "should provide a new timeslot" do
            get :add_timeslots
            expect(response).to redirect_to('/')
        end
        
        it "should update a shift" do
            
            expect{@shift2.update!(:start_time => DateTime.strptime("09/01/2009 17:00", "%m/%d/%Y %H:%M"))}.to change{@shift2.start_time}
        end
        
        it "should destroy a shift" do
            expect {@shift2.destroy} .to change{Shift.count}
        end
        
    end
    
    
    describe "index" do
        # it 'should return something from shifts#index' do
        #     puts "Shifts"
        #     puts Shift.all
        #     puts "End shifts"
        #     get :index
        #     assigns(:shifts).should_not be_nil
        # end
    end
end