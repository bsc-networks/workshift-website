# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the login page$/ then login_path
    when /^the workshifts page$/ then workshifts_path
    when /^the new workshift page$/ then new_workshift_path
    when /^the new category page$/ then new_category_path
    when /^the home page$/ then root_path
    when /^the roster page$/ then roster_path
    when /^the Add Users page$/ then add_users_path
    when /^the categories page$/ then categories_path
    when /^my profile page$/ then user_profile_path(@user)
    when /^the user preferences page$/ then preferences_path
    when /^the reports page$/ then reports_path
    when /^the view report page$/ then view_report_path(@report)
    when /^the edit page for category "(.+)"$/ then
      @category = Category.find_by_name($1)
      edit_category_path(@category)
    when /^the view page for category "(.+)"$/ then
      @category = Category.find_by_name($1)
      category_path(@category)
    when /^the edit page for workshift "(.+)"$/ then
      @workshift = Workshift.find_by_task($1)
      edit_workshift_path(@workshift)
    when /^the view page for workshift "(.+)"$/ then
      @workshift = Workshift.find_by_task($1)
      workshift_path(@workshift)
    when /^(.+)'s profile page$/ then
      user_profile_path(User.find_by_name($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
