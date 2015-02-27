require 'spec_helper'

describe "workshifts/new" do
  before(:each) do
    assign(:workshift, stub_model(Workshift).as_new_record)
  end

  it "renders new workshift form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", workshifts_path, "post" do
    end
  end
end
