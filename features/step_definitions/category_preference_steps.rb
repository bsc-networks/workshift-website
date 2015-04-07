Given /^I have no category preferences$/ do
  @user.preferences.delete_all
end

Given /^I have the following category preferences:$/ do |rankings_table|
  rankings_table.hashes.each do |ranking|
    category_id = Category.find_by_name(ranking[:category]).id
    Preference.create(user_id: @user.id, category_id: category_id,
                      rank: ranking[:rank])
  end
end

When /^(?:|I )rank the "(.+)" category (\d+)$/ do |category_name, rank|
  category_id = Category.find_by_name(category_name).id
  choose "preferences_#{category_id}_#{rank}"
end

Then /^my category preference rankings should be:$/ do |rankings_table|
  rankings_table.hashes.each do |ranking|
    category = Category.find_by_name(ranking[:category])
    preference = @user.preferences.where(category_id: category.id).first
    expect(preference.rank).to eq ranking[:rank].to_i
  end
end
