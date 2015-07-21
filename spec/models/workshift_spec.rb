require 'rails_helper'

describe Workshift do
  it 'has a valid factory' do
    expect(create(:workshift)).to be_valid
  end

  it 'is invalid without an integer day between 0 and 6' do
    expect(build(:workshift, day: -1)).to_not be_valid
    expect(build(:workshift, day: 0)).to be_valid
    expect(build(:workshift, day: 7)).to be_valid
    expect(build(:workshift, day: 8)).to_not be_valid
    expect(build(:workshift, day: 6)).to be_valid
    expect(build(:workshift, day: 2.4)).to_not be_valid
  end

  it 'is invalid when the start time is later than the end time' do
    time = Time.now
    expect(build(:workshift, start_time: time, end_time: time - 1)).to_not be_valid
    expect(build(:workshift, start_time: time, end_time: time)).to_not be_valid
    expect(build(:workshift, start_time: time, end_time: time + 1)).to be_valid
  end

  it 'generates a list of numbers and their associated day names' do
    days = [['Sunday', 0], ['Monday', 1], ['Tuesday', 2], ['Wednesday', 3],
            ['Thursday', 4], ['Friday', 5], ['Saturday', 6], ['Weeklong', 7]]
    expect(Workshift.valid_days).to match_array days
  end

  it 'returns the right weekdays' do
    expect(build(:workshift, day: 0).weekday).to eq("Sunday")
    expect(build(:workshift, day: 1).weekday).to eq("Monday")
    expect(build(:workshift, day: 2).weekday).to eq("Tuesday")
    expect(build(:workshift, day: 3).weekday).to eq("Wednesday")
    expect(build(:workshift, day: 4).weekday).to eq("Thursday")
    expect(build(:workshift, day: 5).weekday).to eq("Friday")
    expect(build(:workshift, day: 6).weekday).to eq("Saturday")
    expect(build(:workshift, day: 7).weekday).to eq("Weeklong")
    expect(build(:workshift, day: 8).weekday).to be_nil
  end

  it 'formats the times correctly' do
    time1 = Time.new(2002, 10, 31, 2, 0, 0, "+02:00")
    time2 = Time.new(2002, 10, 31, 2, 3, 0, "+02:00")
    expect(build(:workshift, start_time: time1, end_time: time2).formatted_start_time).to eq(" 2:00 AM")
    expect(build(:workshift, start_time: time1, end_time: time2).formatted_end_time).to eq(" 2:03 AM")
  end
end
