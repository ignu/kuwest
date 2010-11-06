Given /^I am signed in as "([^\"]*)"$/ do |crendentials|
  email, password = crendentials.split('/')
  @current_user = Given %Q{I signed up as "#{crendentials}"}
  And 'I am on login page'
  fill_in("Email", :with => email)
  fill_in("Password", :with => password)
  click_button("Sign in")
end

Given /^([^\"]*) signed up as "([^\"]*)"$/ do |name, crendentials|
  name = 'sean' if name == "I"
  email, password = crendentials.split('/')
  user = User.create(:email => email, :password => password, :password_confirmation => password, :username => name)
end
