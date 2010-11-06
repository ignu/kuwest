module NavigationHelpers
  def path_to(page_name)
    case page_name

    when /the home\s?page/
      '/'
    when /the wins page/
      '/wins/index'
    when /the new quest definition page/
      '/quest_definitions/new'
    when /the new user page/
      '/users/new'
    when /login page/
      new_user_session_path
    when /^(.*)'s profile page/
      user_path($1)
    when /my profile page/
      user_path(@current_user)
    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
