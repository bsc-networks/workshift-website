require 'spec_helper'

describe "workshifts/edit" do
  before(:each) do
    @workshift = assign(:workshift, stub_model(Workshift))
  end

  it "renders the edit workshift form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", workshift_path(@workshift), "post" do
    end
  end
end
