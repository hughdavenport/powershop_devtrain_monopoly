Given(/^I see the home page$/) do
  visit root_path
end

When(/^I click on "([^"]*)"$/) do |link|
  click_on link
end

When(/^I enter in (.*) as (.*)$/) do |value, field|
    fill_in field.capitalize, :with => value
end
