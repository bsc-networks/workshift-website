require 'rails_helper'

RSpec.describe WeeklyReport, :type => :model do
  it 'has a valid factory for weekly reports' do
    expect(create(:weekly_report)).to be_valid
  end

  it 'includes the creation date in the title' do
    report = create(:weekly_report)
    date = report.created_at.strftime('%m_%d_%y')
    expect(report.title).to include date
  end

  it 'can output the creation date in pretty formatting' do
    Timecop.freeze(Time.local(2010, 6, 19))
    report = create(:weekly_report)
    expect(report.date).to eq '06/19/10'
  end
end
