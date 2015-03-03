require 'rails_helper'

RSpec.describe 'workshifts/index', type: :view do
  before(:each) do
    @workshifts = create_list(:workshift, rand(10..20))
  end

  it 'renders a list of workshifts' do
    render
  end
end
