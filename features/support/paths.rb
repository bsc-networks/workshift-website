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
    when /^the home page$/ then '/'
    when /^the roster page$/ then '/roster'
    when /^the Add Users page$/ then invite_users_path
    when /^the categories page$/ then categories_path
    when /^my profile page$/ then
      user_profile_path(@user)
    when /^the edit page for workshift "(.+)"$/ then
      @workshift = Workshift.find_by_task($1)
      edit_workshift_path(@workshift)
    when /^the user preferences page$/ then preferences_path
    when /^the reports page$/ then reports_workshifts_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

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
