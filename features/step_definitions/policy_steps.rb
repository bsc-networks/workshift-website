And /^I have set the policies for the semester$/ do
    @current_unit.policy = Policy.create!(:first_day => Date.parse("January 16, 2016"), :last_day => Date.parse("May 17, 2016"), 
        :fine_days => Date.parse("March 5, 2016"), :fine_amount => 20, :market_sell_by => 2)
end

And /^the policies for the semester have been set$/ do
    step "I have set the policies for the semester"
end