require 'rails_helper'

RSpec.describe "policies/edit", type: :view do
  before(:each) do
    @policy = assign(:policy, Policy.create!())
  end

  it "renders the edit policy form" do
    render

    assert_select "form[action=?][method=?]", policy_path(@policy), "post" do
    end
  end
end
