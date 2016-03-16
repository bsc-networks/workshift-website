require 'rails_helper'

RSpec.describe "shifts/new", type: :view do
  before(:each) do
    assign(:shift, Shift.new(
      :metashift => nil
    ))
  end

  it "renders new shift form" do
    render

    assert_select "form[action=?][method=?]", shifts_path, "post" do

      assert_select "input#shift_metashift_id[name=?]", "shift[metashift_id]"
    end
  end
end
