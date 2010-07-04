Then /^I should be in (.*)'s followers list$/ do |following|
  response.should have_selector('ul#followers li img', :src => @current_user.photo.url(:thumb)) 
end

Then /^(.*) should be in my following list$/ do |following|
  When %Q{I am on #{@current_user.username}'s profile page}
  following = User.find_by_username(following)
  response.should have_selector('ul#followings li img', :src => following.photo.url(:thumb)) 
end

Given /^I have no followers$/ do
end

Given /^I am not following anyone$/ do
end


Then /^I should not see any followers$/ do
  response.should_not have_selector('ul#followers li') 
end


Then /^I should not see any followings$/ do
  response.should_not have_selector('ul#followings li') 
end
