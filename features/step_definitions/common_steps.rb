Given(/^I see the home page$/) do
  visit root_path
end

When(/^I click on "([^"]*)"$/) do |link|
  click_on link
end
