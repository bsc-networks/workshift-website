require 'rails_helper'

describe User do
  it 'has a valid factory for residents' do
    expect(create(:user)).to be_valid
  end

  it 'has a valid factory for workshift managers' do
    expect(create(:workshift_manager)).to be_valid
    expect(create(:workshift_manager).workshift_manager).to be true
  end

  describe 'wiping current residents from database' do
    it 'removes every user from the database except for workshift managers' do
      workshift_manager_1 = create(:workshift_manager)
      create_list(:user, 30)
      workshift_manager_2 = create(:workshift_manager)
      expect(User.all.count).to eq 32
      User.delete_all_residents
      expect(User.all.count).to eq 2
      expect(User.all[0]).to eq workshift_manager_1
      expect(User.all[1]).to eq workshift_manager_2
    end
  end

  describe 'getting a users role' do
    it 'returns "Resident" if the user is a regular resident' do
      user = create(:user)
      expect(user.role).to eq 'Resident'
    end

    it 'returns "Workshift Manager" if the user is a workshift manager' do
      user = create(:workshift_manager)
      expect(user.role).to eq 'Workshift Manager'
    end
  end

  describe 'inviting new users' do
    it 'fails when an empty string is inputted' do
      expect { User.invite_users('') }.to raise_error ArgumentError
    end

    it 'fails when the input is not formatted correctly' do
      input = "User 1,user@example.com\nUser 2"
      expect { User.invite_users(input) }.to raise_error ArgumentError
    end

    it 'returns the number of people invited' do
      input = "User 1,user_1@example.com\n" \
              "User 2,user_2@example.com\n" \
              "User 3,user_3@example.com\n"
      expect(User.invite_users(input)).to eq 3
    end
  end
end
