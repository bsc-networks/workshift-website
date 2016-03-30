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
    when /^the login\s?page$/
      '/login'
    when /^the home\s?page$/
      '/'
    when /^my profile page$/
      user_profile_path(User.find_by_id(@current_user.id))
    when /^my edit profile page$/
      edit_profile_path(User.find_by_id(@current_user.id))
      
    ### WORKSHIFT MANAGER ###
    when /^the create members\s?page$/
      '/signup'      
    when /^the view weekly history page$/
      '/'
      
    # when /^(.*)'s profile page$/i
      # user_profile_path(User.find_by_login($1))
      
    #### WORKSHIFTS ####
    when /^the create workshifts page$/
      '/'
    when /^the view workshifts page$/
      '/'
    when /^the edit workshift page$/
      '/'
    when /^the assign workshifts page$/
      '/'
      
    #### POLICIES ####
    when /^the view policy page$/
      policy_path
    when /^the set policies page$/
      new_policy_path
    when /^the edit policies page$/
      edit_policy_path
      
      
      
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
