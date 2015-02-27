require 'spec_helper'

describe "workshifts/show" do
  before(:each) do
    @workshift = assign(:workshift, stub_model(Workshift))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
