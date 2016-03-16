require 'rails_helper'

RSpec.describe "metashifts/edit", type: :view do
  before(:each) do
    @metashift = assign(:metashift, Metashift.create!(
      :category => "",
      :description => "",
      :multiplier => 1.5
    ))
  end

  it "renders the edit metashift form" do
    render

    assert_select "form[action=?][method=?]", metashift_path(@metashift), "post" do

      assert_select "input#metashift_category[name=?]", "metashift[category]"

      assert_select "input#metashift_description[name=?]", "metashift[description]"

      assert_select "input#metashift_multiplier[name=?]", "metashift[multiplier]"
    end
  end
end
