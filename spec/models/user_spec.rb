require 'rails_helper'

describe User do
  it 'has a valid factory for residents' do
    expect(create(:user)).to be_valid
  end

  it 'has a valid factory for workshift managers' do
    expect(create(:workshift_manager)).to be_valid
    expect(create(:workshift_manager).workshift_manager).to be true
  end

  it 'does not update a users required hours if its invalid' do
    user = create(:user)
    expect{user.update_required_hours(0.1)}.to raise_error ArgumentError
  end

  it 'returns the correct hours balance messages' do
    user = create(:user)
    user.hours_balance = 5
    expect(user.hours_balance_class).to eq("up_hours")
    expect(user.hours_assigned_class).to eq("down_hours")
    user.hours_balance = -2
    expect(user.hours_balance_class).to eq("down_hours")
    allow(user).to receive(:needed_hours).and_return(-1)
    expect(user.hours_assigned_class).to eq("")
  end

  it 'updates a users required hours' do
    user = create(:user)
    user.preferences
    user.update_required_hours(0.5)
    expect(user.required_hours).to eq(0.5)
    user.update_required_hours(2)
    expect(user.required_hours).to eq(2)
  end

  describe 'updating a users unit' do
    it 'leaves preferences unchanged' do
      unit1 = Unit.find_or_create_by_name(name: 'Unit 1')
      unit2 = Unit.find_or_create_by_name(name: 'Unit 2')
      user = create(:user, unit: unit1)
      expect(user.unit).to eq(unit1)
      user.update_unit(unit2)
      expect(user.unit).to eq(unit2)
    end
  end

  describe 'wiping current residents from database' do
    it 'removes every user from the database except for admins, workshift managers, and unit-admins' do
      admin = create(:admin)
      workshift_manager_1 = create(:workshift_manager)
      unit_admin = create(:unit_level_admin)
      create_list(:user, 30)
      workshift_manager_2 = create(:workshift_manager)
      expect(User.all.count).to eq 34
      User.delete_all_residents(Unit.find_or_create_by_name(name: 'Unit 1'))
      expect(User.all.count).to eq 4
      expect(User.all).to include(admin, workshift_manager_1, workshift_manager_2, unit_admin)
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

    it 'returns "Unit-Level Admin" if the user is a unit admin' do
      user = create(:unit_level_admin)
      expect(user.role).to eq 'Unit-Level Admin'
    end
  end

  describe 'inviting new users' do
    let (:unit) { Unit.find_or_create_by_name(name: 'Unit 1') }

    it 'fails when an empty string is inputted' do
      expect { User.invite_users('', unit) }.to raise_error ArgumentError
    end

    it 'fails when the input is not formatted correctly' do
      input = "User 1,user@example.com\nUser 2"
      expect { User.invite_users(input, unit) }.to raise_error ArgumentError
    end

    it 'returns the number of people invited' do
      input = "User 1,user_1@example.com\n" \
              "User 2,user_2@example.com\n" \
              "User 3,user_3@example.com\n"
      expect(User.invite_users(input, unit)).to eq 3
    end
  end

  describe 'creating preferences when a new category is added' do
    before :each do
      @num_categories = 10
      create_list(:category, @num_categories)
      @created_users = create_list(:user, 20)
      @new_category = Category.create(name: 'New Category', unit: Unit.find_or_create_by_name(name: 'Unit 1'))
      User.create_preferences(@new_category)
    end

    it 'creates a new preferences for each user' do
      @created_users.each do |user|
        pref = Preference.where(user_id: user.id,
                                category_id: @new_category.id).first
        expect(pref).to_not be_nil
      end
    end

    it 'assigns the new preference the lowest rank possible.' do
      @created_users.each do |user|
        pref = Preference.where(user_id: user.id,
                                category_id: @new_category.id).first
        expect(pref.rank).to eq @num_categories + 1
      end
    end
  end

  describe 'updating a users category preferences' do
    before :each do
      @user = create(:user)
      create(:category, id: 1)
      create(:category, id: 2)
    end

    it 'creates the preferences if they do not currently exist' do
      @user.preferences.delete_all
      preferences = { '1' => '1', '2' => '2' }
      @user.update_category_preferences(preferences)
      preferences.each do |category_id, ranking|
        pref = @user.preferences.where(category_id: category_id).first
        expect(pref.rank).to eq ranking.to_i
      end
    end

    it 'updates the preferences if they already exist' do
      create(:preference, user_id: @user_id, category_id: 1, rank: 1)
      create(:preference, user_id: @user_id, category_id: 2, rank: 2)
      preferences = { '1' => '2', '2' => '1' }
      @user.update_category_preferences(preferences)
      preferences.each do |category_id, ranking|
        pref = @user.preferences.where(category_id: category_id).first
        expect(pref.rank).to eq ranking.to_i
      end
    end

    context 'validating the inputted preferences' do
      it 'rejects the preferences if a rank of 0 is present' do
        preferences = { '1' => '0', '2' => '1' }
        expect{ @user.update_category_preferences(preferences) }.to raise_error(ArgumentError)
      end

      it 'rejects the preferences if a rank is entered multiple times' do
        preferences = { '1' => '1', '2' => '1' }
        expect{ @user.update_category_preferences(preferences) }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'modifying a student schedule' do
    before :each do
      @user = create(:user)
    end

    it 'allows creation of a schedule' do
      @user.schedule = User.create_schedule
      expect(@user.schedule).to include('Monday', 'Tuesday', 'Saturday')
      expect(@user.schedule['Monday']['11-12PM']).to eq(true)
    end

    it 'allows updates to a schedule' do
      @user.schedule = User.create_schedule
      new_schedule = User.create_schedule
      expect(new_schedule).to include('Monday')
      new_schedule['Monday']['11-12PM'] = false
      @user.schedule = new_schedule
      expect(@user.schedule['Monday']['11-12PM']).to eq(false)
    end

    it 'parses a schedule from views' do
      schedule_params = User.create_schedule
      schedule_params['Monday']['11-12PM'] = '0'
      schedule_params['Tuesday']['12-1PM'] = 'yes'
      new_schedule = User.parse_schedule_params(schedule_params)
      expect(new_schedule['Monday']['11-12PM']).to eq(false)
      expect(new_schedule['Tuesday']['12-1PM']).to eq(true)
    end
  end
end
