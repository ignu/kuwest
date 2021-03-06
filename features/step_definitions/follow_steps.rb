Then /^I should be in (.*)'s follower list$/ do |following|
  selector = "ul#followers li img[src^='#{@current_user.photo.url(:thumb)}']"
  page.should have_css(selector)
end

Then /^I should not be in bob's follower list$/ do
  selector = "ul#followers li img[src^='#{@current_user.photo.url(:thumb)}']"
  page.should_not have_css(selector)
end

Then /^(.*) should be in my following list$/ do |following|
  When "I am on #{@current_user.username}'s profile page"
  following = User.find_by_username(following)
  selector = "ul#followings li img[src^='#{following.photo.url(:thumb)}']"
  page.should have_css(selector)
end

Given /^I have no followers$/ do
end

Given /^I am not following anyone$/ do
end


Then /^I should not see any followers$/ do
  page.should_not have_css('ul#followers li')
end


Then /^I should not see any followings$/ do
  page.should_not have_css('ul#followings li')
end

Given /^I have followed (.*)$/ do |following|
  Following.create(:follower => @current_user, :following => User.find_by_username(following))
end
