require 'spec_helper'
require 'rails_helper'

describe 'invitations' do
  
  

  

  it 'validates email' do
    visit register_path
    #print current_path
    fill_in 'user_name', with: "John"
    fill_in 'user_email', with: "john1@example.com"
    fill_in 'user_password', with: "secret"
    fill_in 'user_password_confirmation', with: "secret"
    click_button "Create User"
    print current_path
    visit add_users_path
    #print current_path
    fill_in 'user_info', with: 'bla@gmail.com'
    click_button 'Invite User'
    expect(page).to have_content 'Improperly formatted user information'
  end

  describe 'when user is invited' do
    

    it 'shows invitation' do
      visit register_path
      #print current_path
      fill_in 'user_name', with: "John"
      fill_in 'user_email', with: "john1@example.com"
      fill_in 'user_password', with: "secret"
      fill_in 'user_password_confirmation', with: "secret"
      click_button "Create User"
      visit add_users_path
      fill_in 'user_info', with: 'Shirley, shirley@example.com'
      click_button 'Invite User'
      #NEED TO STUB OUT THE EMAIL SENDING BUT IDK HOW
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