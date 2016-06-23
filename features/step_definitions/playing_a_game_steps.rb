DICE_ROLL_SELECTOR         = '#last_dice_roll'
DICE_ROLL_REGEX            = /^You rolled a (?<dice_roll>\d+)$/i

CURRENT_LOCATION_SELECTOR  = "#current_location"
CURRENT_LOCATION_REGEX     = /^You are at (?<location>.*)$/i

BALANCE_SELECTOR           = "#balance"
BALANCE_REGEX              = /^Your balance is \$(?<amount>\d+)$/i

CURRENT_PLAYER_SELECTOR    = "#current_player"

OWNED_PROPERTIES_SELECTOR  = "#owned_properties"
MY_PROPERTIES_SELECTOR     = "#my_properties"

BUY_HOUSE_SELECTOR         = "#buy_house"
BUY_HOTEL_SELECTOR         = "#buy_hotel"

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
  block = lambda { |property| property.name.casecmp(location) == 0 }

  GameState::BOARD.index(block) != GameState::BOARD.rindex(block)
end

def distance_to_move(location)
  current = GameState::BOARD.index { |property| property.name.casecmp(current_location) == 0 }
  wanted = GameState::BOARD.index { |property| property.name.casecmp(location) == 0 }
  wanted += GameState::BOARD.size if wanted < current
  wanted - current
end

def passed_go?(old_location)
  current = GameState::BOARD.index { |property| property.name.casecmp(current_location) == 0 }
  old = GameState::BOARD.index { |property| property.name.casecmp(old_location) == 0 }
  current < old
end


Given(/^It is my turn$/) do
  # The background should set this up
  step 'I go to the game'
  # TODO have a @monopoly that abstracts out the dom
  unless page.has_selector?(CURRENT_PLAYER_SELECTOR)
    step 'another user makes a move (not going to jail)'
    step 'I go to the game'
  end
  # get some state
  step 'I know my location'
  step 'I know my balance'
end

Given(/^It is another users turn$/) do
  step 'another user goes to the game'
  unless page.has_selector?(CURRENT_PLAYER_SELECTOR)
    step 'I make a move (not going to jail)'
    step 'another user goes to the game'
  end
  step 'another user goes to the game'
end

Given(/^I am on (.*)$/) do |location|
  step "I land on #{location}"
  step "I end my turn"
end

Given(/^I am in jail$/) do
  step 'I go to the game'
  step 'I roll 3 doubles'
end

Given(/^I am in jail for (\d+) turns$/) do |number|
  step 'I am in jail'
  number.to_i.times do
    step 'It is my turn'
    step 'I make a move'
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
  puts "#{user} #{user == "I" ? "own" : "owns"} #{property}"
  step "#{user} ends their turn"
end

Given(/^(I|another user) completely (?:own|owns) the (.*) set$/) do |user, colour|
  (colour.capitalize + "Property").constantize.all.each do |property|
    step "#{user} owns #{property.name}"
  end
  step "#{user} has $10000" # Make sure they have money for houses
end

Given(/^(.*) has (\d+)(?: more)? (?:house|houses)$/) do |property, number|
  number.to_i.times do
    step "I buy a house for #{property}"
  end
end

Given(/^(.*) has a hotel$/) do |property|
  step "I buy a hotel for #{property}"
end

Given(/^the (.*) set has (\d+)(?: more)? (?:house|houses) each$/) do |colour, number|
  number.to_i.times do
    (colour.capitalize + "Property").constantize.all.each do |property|
      step "I buy a house for #{property.name}"
    end
  end
end

Given(/^the (.*) set has a hotel each$/) do |colour|
  step "the #{colour} set has 4 houses each"
  (colour.capitalize + "Property").constantize.all.each do |property|
    step "I buy a hotel for #{property.name}"
  end
end

Given(/^(I|another user) completely (?:own|owns) the (.*) set with (\d+) (?:house|houses) each$/) do |user, colour, number|
  step "#{user} completely owns the #{colour} set"
  step "It is #{user == "I" ? "my" : "another users"} turn"
  step "the #{colour} set has #{number} houses each"
end

Given(/^(I|another user) completely (?:own|owns) the (.*) set with a hotel each$/) do |user, colour|
  step "#{user} completely owns the #{colour} set"
  step "It is #{user == "I" ? "my" : "another users"} turn"
  step "the #{colour} set has a hotel each"
end

Given(/^(I|another user) (?:have|has) \$(\d+)$/) do |user, balance|
  # Only works on test/development mode, due to controller check
  step "It is #{user == "I" ? "my" : "another users"} turn"
  within("#set_balance") { step "I enter in #{balance} as balance" }
  step 'I click on "Set balance"'
end

Given(/^32 houses are used$/) do
  step "It is my turn"
  step "I have $100000"
  step "I completely own the brown set with 4 houses each" # 2 * 4 == 8
  step "I completely own the blue set with 4 houses each" # 3 * 4 == 12, +8 == 20
  step "I completely own the pink set with 4 houses each" # 3 * 4 == 12, +20 == 32
end

Given(/^12 hotels are used$/) do
  step "It is my turn"
  step "I have $100000"
  step "I completely own the blue set with a hotel each" # 3
  step "I completely own the pink set with a hotel each" # 3 + 3 == 6
  step "I completely own the orange set with a hotel each" # 3 + 6 == 9
  step "I completely own the red set with a hotel each" # 3 + 9 == 12
end

Given(/^(\d+) chance cards have been used$/) do |number|
  number.to_i.times do
    step "It is my turn"
    if page.has_selector?(IN_JAIL_SELECTOR)
      step "I pay bond"
      step "It is my turn"
    end
    step "I land on Chance"
    step "I draw a card"
    puts "A chance card was drawn"
    step "I end my turn" unless page.has_selector?(IN_JAIL_SELECTOR)
  end
end

Given(/^(\d+) community chest cards have been used$/) do |number|
  number.to_i.times do
    step "It is my turn"
    if page.has_selector?(IN_JAIL_SELECTOR)
      step "I pay bond"
      step "It is my turn"
    end
    step "I land on Community Chest"
    step "I draw a card"
    puts "A chance card was drawn"
    step "I end my turn" unless page.has_selector?(IN_JAIL_SELECTOR)
  end
end

Given(/^I know my location$/) do
  @location = current_location
  puts "I know my location to be #{@location}"
end

Given(/^I know my balance$/) do
  @balance = balance
  @passed_go = 0
  puts "I know my balance to be #{@balance}"
end


When(/^(I|another user) (?:land|lands) on (.*)$/) do |user, location|
  if current_location.downcase == location.downcase
    step "#{user} makes a move"
    step "It is #{user == "I" ? "my" : "another users"} turn"
  end
  2.times { step "#{user} rolls a 1" } if ambiguous_location?(current_location) # May bankrupt, but hey, only when on chance/community chest
  old_location = current_location
  step "#{user} rolls a 0"
  step "#{user} rolls a #{distance_to_move(location)}"
  @passed_go += 1 if user == "I" && @passed_go && passed_go?(old_location)
end

When(/^(I|another user) (?:pass|passes) (.*)$/) do |user, location|
  if current_location.downcase == location.downcase
    step "#{user} makes a move"
    step "It is #{user == "I" ? "my" : "another users"} turn"
  end
  2.times { step "#{user} rolls a 1" } if ambiguous_location?(current_location) # May bankrupt, but hey, only when on chance/community chest
  old_location = current_location
  step "#{user} rolls a #{distance_to_move(location)}"
  step "#{user} rolls a 1"
  @passed_go += 1 if user == "I" && @passed_go && passed_go?(old_location)
end

When(/^(I|another user) (?:roll|rolls) the dice$/) do |user|
  # First step logs in
  step "#{user} goes to the game"
  step 'I click on "Roll Dice"'
end

When(/^(I|another user) (?:roll|rolls) two dice$/) do |user|
  2.times do
    step "#{user} rolls the dice"
    puts "#{user} rolled a #{dice_roll}"
  end
end

When(/^(I|another user) (?:roll|rolls) two dice \(not doubles\)$/) do |user|
  step "#{user} rolls the dice"
            # make 0-based for % operation, then 1-based for step
  puts "#{user} rolled a #{dice_roll}, then a #{(((dice_roll.to_i - 1) + 1) % 6) + 1}"
  step "#{user} rolls a #{(((dice_roll.to_i - 1) + 1) % 6) + 1}"
end

When(/^(I|another user) (?:roll|rolls) (a|\d+) (?:double|doubles)$/) do |user, number|
  number = 1 if number == "a"
  number.to_i.times do
    step "#{user} draws \"No card\"" if page.has_selector?("#draw_card")
    step "#{user} rolls the dice"
    puts "#{user} rolled a #{dice_roll} twice"
    step "#{user} rolls a #{dice_roll}"
  end
end

When(/^(?:I|another user) (?:roll|rolls) a (\d+)$/) do |number|
  # Works only in testing and development mode, controller accepts a number for dice roll
  within("#dice_roll") { step "I enter in #{number} as dice roll" }
  step 'I click on "Roll Dice"'
end

When(/^(?:I|another user) (?:end|ends) (?:my|their) turn$/) do
  step 'I draw "No card"' if page.has_selector?("#draw_card")
  step 'I click on "End turn"'
end

When(/^(I|another user) (?:make|makes) a move$/) do |user|
  step "#{user} rolls two dice (not doubles)"
  step "#{user} ends their turn"
end

When(/^(I|another user) (?:make|makes) a move \(not going to jail\)$/) do |user|
  step "#{user} goes to the game"
  if current_location.downcase == "jail"
    step "#{user} lands on Go"
  else
    step "#{user} lands on Jail"
  end
  step "#{user} ends their turn"
end

When(/^(?:I|another user) (?:buy|buys) the property$/) do
  step 'I click on "Buy property"'
end

When(/^(?:I|another user) (?:buy|buys) a house for (.*)$/) do |property|
  within(BUY_HOUSE_SELECTOR) { step "I select #{property} as property" }
  step 'I click on "Buy house"'
  puts "a house was purchased for #{property}"
end

When(/^(?:I|another user) (?:buy|buys) a hotel for (.*)$/) do |property|
  within(BUY_HOTEL_SELECTOR) { step "I select #{property} as property" }
  step 'I click on "Buy hotel"'
  puts "a hotel was purchased for #{property}"
end

When(/^(?:I|another user) (?:pay| pays) bond$/) do
  step 'I click on "Pay bond"'
end

When(/^(?:I|another user) (?:draw| draws) a card$/) do
  step 'I click on "Draw card"'
end

When(/^(?:I|another user) (?:draw|draws) \"(.*)\"$/) do |card|
  # Works only in testing and development mode, controller accepts a number for dice roll
  within("#draw_card") { step "I select #{card} as card" }
  step 'I click on "Draw card"'
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
    puts "I am on #{current_location}"
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

Then(/^(I|another user) should( not)? have \$(\d+) balance$/) do |user, negation, amount|
  # First step will login as user
  step "#{user} goes to the game"
  if negation
    expect(balance).not_to eq amount
  else
    expect(balance).to eq amount
  end
end

Then(/^I should (lose|gain) \$(\d+)$/) do |direction, amount|
  step "I go to the game"
  multiplier = (direction == "lose" ? -1 : 1)
  puts "Ignoring the fact that I've passed go #{@passed_go} times" if @passed_go && @passed_go > 0
  @balance = @balance.to_i + 200 * @passed_go if @passed_go
  expect(@balance.to_i + multiplier * amount.to_i).to eq balance.to_i
end

Then(/^I should( not)? gain go money$/) do |negation|
  @passed_go = 0
  step "I should gain $#{negation ? "0" : "200"}"
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

Then(/^I should (lose|gain) (\d+) times the dice roll$/) do |direction, multiplier|
  puts "The dice roll is #{dice_roll}"
  step "I should #{direction} $#{dice_roll.to_i * multiplier.to_i}"
end

Then(/^I should( not)? be able to buy the property$/) do |negation|
  step "I should#{negation} see \"Buy property\""
end

Then(/^I should( not)? be able to buy a house$/) do |negation|
  step "I should#{negation} see \"Buy house\""
end

Then(/^I should( not)? be able to buy a house for (.*)$/) do |negation, property|
  if negation
    # Either can't buy any, or can't buy that particular one
    expect(find(BUY_HOUSE_SELECTOR)).not_to have_content(property) if page.has_selector?(BUY_HOUSE_SELECTOR)
  else
    expect(find(BUY_HOUSE_SELECTOR)).to have_content(property)
  end
end

Then(/^I should( not)? be able to buy a hotel$/) do |negation|
  step "I should#{negation} see \"Buy hotel\""
end

Then(/^I should( not)? be able to buy a hotel for (.*)$/) do |negation, property|
  if negation
    # Either can't buy any, or can't buy that particular one
    expect(find(BUY_HOTEL_SELECTOR)).not_to have_content(property) if page.has_selector?(BUY_HOTEL_SELECTOR)
  else
    expect(find(BUY_HOTEL_SELECTOR)).to have_content(property)
  end
end

Then(/^(.*) should have (\d+) (?:house|houses)$/) do |property, number|
  expect(find("##{property.downcase.gsub(" ", "_")}_houses")).to have_content(/with #{number} (?:house|houses)/i)
end

Then(/^(.*) should have a hotel$/) do |property|
  expect(find("##{property.downcase.gsub(" ", "_")}_hotel")).to have_content(/and a hotel/i)
end

Then(/^(?:I|another user) should( not)? be able to pay bond$/) do |negation|
  step "I should#{negation} see \"Pay bond\""
end

Then(/^(?:I|another user) should( not)? be able to draw a card$/) do |negation|
  step "I should#{negation} see \"Draw card\""
end

Then(/^(?:I|another user) should( not)? be able to end (?:my|their) turn$/) do |negation|
  step "I should#{negation} see \"End turn\""
end

Then(/^(I|another user) should( not)? be bankrupt$/) do |user, negation|
  step "#{user} should#{negation} have $0 balance"
  step "I should#{negation} see \"You are bankrupt\""
end
