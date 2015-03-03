require 'rails_helper'

describe Workshift do
  it 'has a valid factory' do
    expect(create(:workshift)).to be_valid
  end

  it 'is invalid without an integer day between 0 and 6' do
    expect(build(:workshift, day: -1)).to_not be_valid
    expect(build(:workshift, day: 0)).to be_valid
    expect(build(:workshift, day: 7)).to_not be_valid
    expect(build(:workshift, day: 6)).to be_valid
    expect(build(:workshift, day: 2.4)).to_not be_valid
  end

  it 'is invalid without a positive integer number of people_needed' do
    expect(build(:workshift, people_needed: 0)).to_not be_valid
    expect(build(:workshift, people_needed: -1)).to_not be_valid
    expect(build(:workshift, people_needed: 1)).to be_valid
    expect(build(:workshift, people_needed: 1.1)).to_not be_valid
  end

  it 'is invalid when the start time is later than the end time' do
    time = Time.now
    expect(build(:workshift, start_time: time, end_time: time - 1)).to_not be_valid
    expect(build(:workshift, start_time: time, end_time: time)).to_not be_valid
    expect(build(:workshift, start_time: time, end_time: time + 1)).to be_valid
  end

  it 'generates a list of numbers and their associated day names' do
    days = [['Sunday', 0], ['Monday', 1], ['Tuesday', 2], ['Wednesday', 3],
            ['Thursday', 4], ['Friday', 5], ['Saturday', 6]]
    expect(Workshift.valid_days).to match_array days
  end
end
