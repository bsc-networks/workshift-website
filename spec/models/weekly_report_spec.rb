require 'rails_helper'

RSpec.describe WeeklyReport, :type => :model do
  it 'has a valid factory for weekly reports' do
    expect(create(:weekly_report)).to be_valid
  end

  it 'includes the period in the title' do
    report = create(:weekly_report)
    expect(report.title).to include report.period.gsub('/', '_')
  end

  describe 'getting the dates of the report' do
    before :each do
      Timecop.freeze(Time.zone.parse('Wednesday, May 6th, 2015'))
      @report = create(:weekly_report)
    end

    it 'uses the Sunday of the previous week as the starting date' do
      date = Time.zone.parse('Sunday, April 26th, 2015')
      expect(@report.start_date).to eq date
    end

    it 'uses the previous Saturday as the ending date' do
      date = Time.zone.parse('Saturday, May 2nd, 2015')
      expect(@report.end_date.beginning_of_day).to eq date
    end

    it 'constructs a period from the starting date to the ending' do
      start_date = Time.zone.parse('Sunday, April 26th, 2015')
      end_date = Time.zone.parse('Saturday, May 2nd, 2015')
      period = "#{start_date.strftime('%m/%d/%y')}-#{end_date.strftime('%m/%d/%y')}"
      expect(@report.period).to eq period
    end
  end
end
