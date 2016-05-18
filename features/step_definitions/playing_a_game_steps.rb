DICE_ROLL_SELECTOR         = '#last_dice_roll'
DICE_ROLL_REGEX            = /^You rolled a (?<dice_roll>\d+)$/i

CURRENT_LOCATION_SELECTOR  = "#current_location"
CURRENT_LOCATION_REGEX     = /^You are at (?<location>.*)$/i

BALANCE_SELECTOR           = "#balance"
BALANCE_REGEX              = /^Your balance is \$(?<amount>\d+)$/i

CURRENT_PLAYER_SELECTOR    = "#current_player"

OWNED_PROPERTIES_SELECTOR  = "#owned_properties"
MY_PROPERTIES_SELECTOR     = "#my_properties"

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

def ambiguous_location?(location)
  GameState::BOARD.index(location.downcase.gsub(" ", "_").to_sym) != GameState::BOARD.rindex(location.downcase.gsub(" ", "_").to_sym)
end

def distance_to_move(location)
  current = GameState::BOARD.index(current_location.downcase.gsub(" ", "_").to_sym)
  wanted = GameState::BOARD.index(location.downcase.gsub(" ", "_").to_sym)
  if wanted < current
    wanted += GameState::BOARD.size if wanted < current
    @passed_go = true
  end
  wanted - current
end

Given(/^It is my turn$/) do
  # The background should set this up
  step 'I go to the game'
  # TODO have a @monopoly that abstracts out the dom
  unless page.has_selector?(CURRENT_PLAYER_SELECTOR)
    step 'another user makes a move'
    step 'I go to the game'
  end
  # get some state
  step 'I know my location'
  step 'I know my balance'
end

Given(/^It is another users turn$/) do
  step 'another user goes to the game'
  unless page.has_selector?(CURRENT_PLAYER_SELECTOR)
    step 'I make a move'
    step 'another user goes to the game'
  end
  step 'another user goes to the game'
end

Given(/^I am in jail$/) do
  step 'I go to the game'
  step 'I roll 3 doubles'
end

Given(/^I am in jail for (\d+) turns$/) do |number|
  step 'I am in jail'
  number.to_i.times do
    step 'It is my turn'
    step 'I roll two dice (not doubles)'
    step 'I end my turn'
  end
end

Given(/^(.*) is not owned$/) do |property|
  # It shouldn't be owned at the start
end

Given(/^(I|another user) (?:own|owns) (.*)$/) do |user, property|
  # First step logs in as user
  step "It is #{user == "I" ? "my" : "another users"} turn"
  step "#{user} lands on #{property}"
  step "#{user} buys the property"
  step "#{user} ends their turn"
end

Given(/^I have \$(\d+)$/) do |balance|
  # Only works on test/development mode, due to controller check
  step 'It is my turn'
  within("#set_balance") { step "I enter in #{balance} as balance" }
  step 'I click on "Set balance"'
end

Given(/^I know my location$/) do
  @location = current_location
end

Given(/^I know my balance$/) do
  @balance = balance
  @passed_go = false
end


When(/^(I|another user) (?:land|lands) on (.*)$/) do |user, location|
  if current_location.downcase == location.downcase
    step "#{user} makes a move"
    step "It is #{user == "I" ? "my" : "another users"} turn"
  end
  2.times { step "#{user} rolls a 1" } if ambiguous_location?(current_location) # May bankrupt, but hey, only when on chance/community chest
  step "#{user} rolls a 0"
  step "#{user} rolls a #{distance_to_move(location)}"
end

When(/^(I|another user) (?:pass|passes) (.*)$/) do |user, location|
  if current_location.downcase == location.downcase
    step "#{user} makes a move"
    step "It is #{user == "I" ? "my" : "another users"} turn"
  end
  2.times { step "#{user} rolls a 1" } if ambiguous_location?(current_location) # May bankrupt, but hey, only when on chance/community chest
  step "#{user} rolls a #{distance_to_move(location)}"
  step "#{user} rolls a 1"
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
  step "#{user} rolls a #{(((dice_roll.to_i - 1) + 1) % 6) + 1}"
end

When(/^(I|another user) (?:roll|rolls) (a|\d+) (?:double|doubles)$/) do |user, number|
  number = 1 if number == "a"
  number.to_i.times do
    step "#{user} rolls the dice"
    step "#{user} rolls a #{dice_roll}"
  end
end

When(/^(?:I|another user) (?:roll|rolls) a (\d+)$/) do |number|
  # Works only in testing and development mode, controller accepts a number for dice roll
  within("#dice_roll") { step "I enter in #{number} as dice roll" }
  step 'I click on "Roll Dice"'
end

When(/^(?:I|another user) (?:end|ends) (?:my|their) turn$/) do
  step 'I click on "End turn"'
end

When(/^(I|another user) (?:make|makes) a move$/) do |user|
  step "#{user} rolls two dice (not doubles)"
  step "#{user} ends their turn"
end

When(/^(?:I|another user) (?:buy|buys) the property$/) do
  step 'I click on "Buy property"'
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
  @balance = @balance.to_i + 200 if @passed_go && multiplier == -1
  expect(@balance.to_i + multiplier * amount.to_i).to eq balance.to_i
end

Then(/^(I|another user) should be the current player$/) do |user|
  # First step will login as user
  step "#{user} goes to the game"
  expect(page).to have_selector(CURRENT_PLAYER_SELECTOR)
end

Then(/^(I|another user) should own (.*)$/) do |user, property|
  # First step will login as user
  step "#{user} goes to the game"
  expect(find(MY_PROPERTIES_SELECTOR)).to have_content(property)
end

Then(/^(.*) should( not)? be owned$/) do |property, negation|
  if negation
    expect(find(OWNED_PROPERTIES_SELECTOR)).not_to have_content(property)
  else
    expect(find(OWNED_PROPERTIES_SELECTOR)).to have_content(property)
  end
end

Then(/^I should( not)? be able to roll the dice$/) do |negation|
  step "I should#{negation} see \"Roll Dice\""
end

Then(/^I should lose (\d+) times the dice roll$/) do |multiplier|
  step "I should lose $#{dice_roll.to_i * multiplier.to_i}"
end

Then(/^I should( not)? be able to buy the property$/) do |negation|
  step "I should#{negation} see \"Buy property\""
end
