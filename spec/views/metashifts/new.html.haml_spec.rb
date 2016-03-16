require 'rails_helper'

RSpec.describe "metashifts/new", type: :view do
  before(:each) do
    assign(:metashift, Metashift.new(
      :category => "",
      :description => "",
      :multiplier => 1.5
    ))
  end

  it "renders new metashift form" do
    render

    assert_select "form[action=?][method=?]", metashifts_path, "post" do

      assert_select "input#metashift_category[name=?]", "metashift[category]"

      assert_select "input#metashift_description[name=?]", "metashift[description]"

      assert_select "input#metashift_multiplier[name=?]", "metashift[multiplier]"
    end
  end
end
