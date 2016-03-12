require 'rails_helper'

RSpec.describe "policies/index", type: :view do
  before(:each) do
    assign(:policies, [
      Policy.create!(),
      Policy.create!()
    ])
  end

  it "renders a list of policies" do
    render
  end
end
