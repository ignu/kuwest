When /^I save and open the page$/ do
  save_and_open_page
end

Then /^show me the page$/ do
  save_and_open_page
end

When 'I debug' do
  debugger
end

When /^I puts "([^\"]*)"$/ do |str|
  puts str
end

When /^I look at the whole response$/ do
  pp response.driver.response.headers
  puts ""
  puts response.body
end

