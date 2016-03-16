require 'rails_helper'

RSpec.describe "metashifts/show", type: :view do
  before(:each) do
    @metashift = assign(:metashift, Metashift.create!(
      :category => "",
      :description => "",
      :multiplier => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/1.5/)
  end
end
