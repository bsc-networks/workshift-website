require 'rails_helper'

RSpec.describe WorkshiftAssignment, :type => :model do
  it 'has a valid factory' do
    expect(create(:workshift_assignment)).to be_valid
  end

  it 'has same day of the week as parent workshift' do
    @assignment = create(:workshift_assignment)
    expect(@assignment.date.strftime("%w").to_i).to eq(@assignment.workshift.day)
  end
end
