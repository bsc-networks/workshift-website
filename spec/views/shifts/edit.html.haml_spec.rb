require 'rails_helper'

RSpec.describe "shifts/edit", type: :view do
  before(:each) do
    @shift = assign(:shift, Shift.create!(
      :metashift => nil
    ))
  end

  it "renders the edit shift form" do
    render

    assert_select "form[action=?][method=?]", shift_path(@shift), "post" do

      assert_select "input#shift_metashift_id[name=?]", "shift[metashift_id]"
    end
  end
end
