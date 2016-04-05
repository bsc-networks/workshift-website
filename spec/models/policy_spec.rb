require 'rails_helper'

RSpec.describe User, type: :model do
    before :each do
        @policy = Policy.create!(:first_day => "January 1, 2016",
            :last_day => "May 17, 2016", :fine_amount => 30,
            :fine_days => [Date.parse("February 5, 2016"), Date.parse("March 13, 2016"), Date.parse("April 25, 2016")],
            :market_sell_by => 3)
    end
    it "should get the first day of the semester as a string" do
        expect(@policy.get_first_day).to eq("January 01, 2016") 
    end
    it "should get the last day of the semester as a string" do
        expect(@policy.get_last_day).to eq("May 17, 2016") 
    end
    it "should get the fine days for the semester as a string" do
        expect(@policy.get_fine_days).to eq("February 05, 2016, March 13, 2016, April 25, 2016") 
    end
end
 