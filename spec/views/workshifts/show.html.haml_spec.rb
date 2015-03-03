require 'rails_helper'

RSpec.describe 'workshifts/show', type: :view do
  before(:each) do
    @workshift = create(:workshift)
  end

  it 'renders attributes in <p>' do
    render
  end
end
