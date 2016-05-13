DICE_ROLL_SELECTOR         = '#dice_roll'
DICE_ROLL_REGEX            = /^You rolled a (?<dice_roll>\d+)$/i

CURRENT_LOCATION_SELECTOR  = "#current_location"
CURRENT_LOCATION_REGEX     = /^You are at (?<location>.*)$/i

BALANCE_SELECTOR           = "#balance"
BALANCE_REGEX              = /^Your balance is \$(?<amount>\d+)$/i

CURRENT_PLAYER_SELECTOR    = "#current_player"

IN_JAIL_SELECTOR           = "#in_jail"

def dice_roll
  find(DICE_ROLL_SELECTOR).text.gsub(DICE_ROLL_REGEX, '\\k<dice_roll>')
end

def current_location
  find(CURRENT_LOCATION_SELECTOR).text.gsub(CURRENT_LOCATION_REGEX, '\\k<location>')
end

def balance
  find(BALANCE_SELECTOR).text.gsub(BALANCE_REGEX, '\\k<amount>')
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

Given(/^I know my location$/) do
  @location = current_location
end

Given(/^I know my balance$/) do
  @balance = balance
end

Given(/^I am on (.*)$/) do |location|
  unless current_location.downcase == location
    # Move
  end
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
  if negation
    step "I should be on #{@location}"
  else
    step "I should not be on #{@location}"
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

Then(/^(I|another user) should( not)? be on (.*)$/) do |user, negation, location|
  step "#{user} goes to the game"
  if negation
    expect(current_location.downcase).not_to eq location.downcase
  else
    expect(current_location.downcase).to eq location.downcase
  end
end

Then(/^(I|another user) should have \$(\d+) balance$/) do |user, amount|
  # First step will login as user
  step "#{user} goes to the game"
  expect(balance).to eq amount
end

Then(/^I should (lose|gain) \$(\d+)$/) do |direction, amount|
  multiplier = (direction == "lose" ? -1 : 1)
  expect(@balance + multiplier * amount).to eq balance
end

Then(/^(I|another user) should be the current player$/) do |user|
  # First step will login as user
  step "#{user} goes to the game"
  expect(page).to have_selector(CURRENT_PLAYER_SELECTOR)
end
