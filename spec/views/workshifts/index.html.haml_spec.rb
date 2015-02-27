require 'spec_helper'

describe "workshifts/index" do
  before(:each) do
    assign(:workshifts, [
      stub_model(Workshift),
      stub_model(Workshift)
    ])
  end

  it "renders a list of workshifts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
