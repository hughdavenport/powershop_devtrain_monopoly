DICE_ROLL_SELECTOR = '#dice_roll'
DICE_ROLL_REGEX    = /^You rolled a (?<dice_roll>\d+)$/i

CURRENT_PLAYER_SELECTOR = "#current_player"

IN_JAIL_SELECTOR = "#in_jail"

def dice_roll
  find(DICE_ROLL_SELECTOR).text.gsub(DICE_ROLL_REGEX, '\\k<dice_roll>')
end

Given(/^It is my turn$/) do
  # The background should set this up
  step 'I go to the game'
  unless page.has_selector?(CURRENT_PLAYER_SELECTOR)
    step 'another user rolls two dice (not doubles)'
  end
  step 'I go to the game'
end

Given(/^I am in jail$/) do
  step 'I go to the game'
  step 'I roll 3 doubles'
end


When(/^(I|another user) (?:roll|rolls) the dice$/) do |user|
  # First step logs in
  step "#{user} goes to the game"
  step 'I click on "Roll Dice"'
end

When(/^(I|another user) (?:roll|rolls) two dice$/) do |user|
  2.times { step "#{user} rolls the dice" }
end

When(/^(I|another user) (?:roll|rolls) two dice \(not doubles\)$/) do |user|
  step "#{user} rolls the dice"
            # make 0-based for % operation, then 1-based for step
  step "I roll a #{(((dice_roll.to_i - 1) + 1) % 6) + 1}"
end

When(/^(I|another user) (?:roll|rolls) (a|\d+) (?:double|doubles)$/) do |user, number|
  number = 1 if number == "a"
  number.to_i.times do
    step "#{user} rolls the dice"
    step "I roll a #{dice_roll}"
  end
end

When(/^I roll a (\d+)$/) do |number|
  # Need to create the dice manually here...
  # Add to the game events model?
  # or change controller to accept number when in testing mode...
  step "I enter in #{number} as dice roll"
  step 'I click on "Roll Dice"'
end


Then(/^I should see a dice roll$/) do
  expect(page).to have_selector(DICE_ROLL_SELECTOR)
end

Then(/^It should( not)? be my turn$/) do |negation|
  if negation
    expect(page).not_to have_selector(CURRENT_PLAYER_SELECTOR)
  else
    expect(page).to have_selector(CURRENT_PLAYER_SELECTOR)
  end
end

Then(/^I should( not)? move along the board$/) do |negation|
  # Assume that we start on go, and only test movement from there
  # TODO: change assumption!!
  if negation
    step 'I should be on Go'
  else
    step 'I should not be on Go'
  end
end

Then(/^I should be in jail$/) do
  step 'I should be on Jail' # test the actual piece move
  expect(page).to have_selector(IN_JAIL_SELECTOR)
end

Then(/^I should be visiting jail$/) do
  step 'I should be on Jail' # we should be on the jail square, but not "in" jail
  expect(page).not_to have_selector(IN_JAIL_SELECTOR)
end
