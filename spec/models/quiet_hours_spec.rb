require 'rails_helper'

describe QuietHour do
	before(:each) do
		@quiet_hour = create(:quiet_hour)
    @most_start_time = Time.parse('9:00PM')
    @most_end_time = Time.parse('10:00AM')
    ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday'].each do |day|
      day_quiet_hour = create(:day_quiet_hour)
      day_quiet_hour.save
      day_quiet_hour.update_attributes(day: day)
      @quiet_hour.day_quiet_hours << day_quiet_hour
      day_quiet_hour.save
      @quiet_hour.day_quiet_hours.where(day: day).first.update_attributes(:start_time => @most_start_time, :end_time => @most_end_time)
    end
    @other_start_time = Time.parse('10:00PM')
    @other_end_time = Time.parse('11:00AM')
    @quiet_hour.day_quiet_hours.where(day: 'monday').first.update_attributes(:start_time => @other_start_time, :end_time => @other_end_time)
	end

	describe 'getting the start and end times for some day' do
		it 'returns the start time of the correct day' do
			expect(@quiet_hour.get_day_start_time('sunday').seconds_since_midnight).to eq(@most_start_time.seconds_since_midnight)
			expect(@quiet_hour.get_day_start_time('monday').seconds_since_midnight).to eq(@other_start_time.seconds_since_midnight)
		end
		it 'returns the end time of the correct day' do
			expect(@quiet_hour.get_day_end_time('sunday').seconds_since_midnight).to eq(@most_end_time.seconds_since_midnight)
			expect(@quiet_hour.get_day_end_time('monday').seconds_since_midnight).to eq(@other_end_time.seconds_since_midnight)
		end
	end

	describe 'setting start and end times for some day' do
		it 'sets the start time of the correct day' do
			@quiet_hour.set_day_start_time('tuesday', @other_start_time)
			expect(@quiet_hour.get_day_start_time('tuesday').seconds_since_midnight).to eq(@other_start_time.seconds_since_midnight)
		end
		it 'sets the end time of the correct day' do
			@quiet_hour.set_day_end_time('wednesday', @other_end_time)
			expect(@quiet_hour.get_day_end_time('wednesday').seconds_since_midnight).to eq(@other_end_time.seconds_since_midnight)
		end
	end
end
