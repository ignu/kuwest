# Common step definitions

def create_my_user(params)
	unless user = User.find_by_email(params[:email])
		params[:password_confirmation] = params[:password]
		user = User.create(params)
		user.update_attribute(:confirmation_token, nil)
		user.update_attribute(:confirmed_at, Time.now)
	end
	user
end

Given /^I am logged in as (.*)$/ do |email|
	@password = "test123"
	@current_user = create_my_user(:email => email, :password => @password)
	visit new_user_session_path
	fill_in("Email", :with => email)
	fill_in("Password", :with => @password)
	click_button("Sign in")
end

Given /^a win exists$/ do
	@win = Win.new
	@win.user 		= @current_user
	@win.verb 		= "ran"
	@win.noun 		= "mile"
	@win.amount 	= 1
	@win.save
end

When /^I click on a "([^\"]*)" link$/ do |link|
	click_link(link)		
end
