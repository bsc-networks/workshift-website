require 'rails_helper'

RSpec.describe "policies/show", type: :view do
  before(:each) do
    @policy = assign(:policy, Policy.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
