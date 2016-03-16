require 'rails_helper'

RSpec.describe "shifts/index", type: :view do
  before(:each) do
    assign(:shifts, [
      Shift.create!(
        :metashift => nil
      ),
      Shift.create!(
        :metashift => nil
      )
    ])
  end

  it "renders a list of shifts" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
