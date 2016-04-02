require 'rails_helper'
describe Unit do
    it { 
        should have_many(:users) 
        should have_one(:policy) 
    }
end