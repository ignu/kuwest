module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      '/'
		when /the wins page/
			'/wins/index'
    when /the new quest page/
      '/quest_definitions/new'
    when /the new user page/
      '/users/new'
    when /login page/
      new_user_session_path
    when /^(.*)'s profile page/
      user_show_path(:id => User.find_by_username($1).id)
    when /my profile page/
      user_show_path(:id => @current_user.id)
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
