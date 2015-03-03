require 'rails_helper'

RSpec.describe 'workshifts/edit', type: :view do
  before(:each) do
    @workshift = create(:workshift)
  end

  it 'renders the edit workshift form' do
    render

    assert_select 'form[action=?][method=?]', workshift_path(@workshift),
                  'post' do
    end
  end
end
