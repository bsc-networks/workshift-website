require 'spec_helper'
require 'rails_helper'

describe 'invitations' do

  before :each do
        
    visit add_users_path
  end

  it 'validates email' do
    visit add_users_path
    fill_in 'user_info', with: 'blabla'
    click_button 'Invite User'
    expect(page).to have_content 'Improperly formatted user information'
  end

  describe 'when user is invited' do
    before do
      fill_in 'User Names and Emails', with: 'shirley@example.com'
      click_button 'Invite User'
    end

    it 'shows invitation' do
      expect(page).to have_content 'invited'
    end

    context 'user accepts invitation' do
      before do
        click_link 'Sign out'

        open_email 'shirley@example.com'
        visit_in_email 'Accept invitation'

        fill_in 'Password', with: 'pw'
        fill_in 'Password confirmation', with: 'pw'
        click_button 'Set my password'
      end

      it 'confirms account creation' do
        expect(page).to have_content 'Your password was set successfully'
      end
    end
  end
end