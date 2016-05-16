MAIN_USER = "testinguser"
ANOTHER_USER = "anotheruser"

# *VERY* basic login capability
def loginas(user)
  uri = URI.parse(current_url)
  query = URI.decode_www_form(uri.query ? uri.query : '').to_h
  query[:username] = user
  uri.query = URI.encode_www_form(query)
  visit uri.to_s
end

Given(/^I have a user$/) do
  User.create!(username: MAIN_USER)
end

Given(/^there is another user$/) do
  User.create!(username: ANOTHER_USER)
end


Given(/^(I|another user) (?:see|sees) the home page$/) do |pronoun|
  visit root_path
  loginas(pronoun == "I" ? MAIN_USER : ANOTHER_USER)
end


When(/^I click on "([^"]*)"$/) do |link|
  click_on link
end

When(/^I click on "([^"]*)" if it is there$/) do |link|
  step "I click on \"#{link}\"" if page.has_selector?(:link_or_button, link)
end

When(/^I enter in (.*) as (.*)$/) do |value, field|
  fill_in field.capitalize, :with => value
end

When(/^I select (.*) as (.*)$/) do |value, field|
  select value, :from => field.capitalize
end


Then(/^I should( not)? see the content (.*)$/) do |negation, content|
  if negation
    expect(page).not_to have_content(content)
  else
    expect(page).to have_content(content)
  end
end

Then(/^I should( not)? see "(.*)$/) do |negation, content|
  step "I should#{negation} see the content #{content}"
end
