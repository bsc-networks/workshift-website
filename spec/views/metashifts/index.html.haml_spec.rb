require 'rails_helper'

RSpec.describe "metashifts/index", type: :view do
  before(:each) do
    assign(:metashifts, [
      Metashift.create!(
        :category => "",
        :description => "",
        :multiplier => 1.5
      ),
      Metashift.create!(
        :category => "",
        :description => "",
        :multiplier => 1.5
      )
    ])
  end

  it "renders a list of metashifts" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
