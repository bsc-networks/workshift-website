require 'rails_helper'

RSpec.describe "policies/new", type: :view do
  before(:each) do
    assign(:policy, Policy.new())
  end

  it "renders new policy form" do
    render

    assert_select "form[action=?][method=?]", policies_path, "post" do
    end
  end
end
