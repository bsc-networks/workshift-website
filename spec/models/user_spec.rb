require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'check permissions' do
    before(:each) do
      @member = FactoryGirl.build(:user, :first_name => 'Maura',
      :last_name => 'Fitz', :permissions => User::PERMISSION[:member])
    end
    
    it 'should be permission level member only' do
        @member.is_member.should be_truthy
        @member.is_manager.should be_falsy
        @member.is_ws_manager.should be_falsy
    end
    
    it 'should have a correct full name' do
        expect(@member.full_name).to eq("Maura Fitz")
    end

  end
end
