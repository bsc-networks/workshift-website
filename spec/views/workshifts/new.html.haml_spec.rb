require 'rails_helper'

RSpec.describe "workshifts/new", :type => :view do
  before(:each) do
    assign(:workshift, Workshift.new())
  end

  it "renders new workshift form" do
    render

    assert_select "form[action=?][method=?]", workshifts_path, "post" do
    end
  end
end
