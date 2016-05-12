DICE_ROLL_SELECTOR = '#dice_roll'
DICE_ROLL_REGEX    = /^You rolled a (?<dice_roll>\d+)$/i

CURRENT_PLAYER_SELECTOR = "#current_player"

def dice_roll
  find(DICE_ROLL_SELECTOR).text.gsub(DICE_ROLL_REGEX, '\\k<dice_roll>')
end

Given(/^It is my turn$/) do
  # The background should set this up
  step "I go to the game"
end


When(/^I roll the dice$/) do
  step 'I click on "Roll Dice"'
end

When(/^I roll two dice$/) do
  2.times { step 'I roll the dice' }
end

When(/^I roll two dice \(not doubles\)$/) do
  step 'I roll the dice'
            # make 0-based for % operation, then 1-based for step
  step "I roll a #{(((dice_roll.to_i - 1) + 1) % 6) + 1}"
end

When(/^I roll (a|\d+) (?:double|doubles)$/) do |number|
  number = 1 if number == "a"
  number.to_i.times do
    step 'I roll the dice'
    step "I roll a #{dice_roll}"
  end
end

When(/^I roll a (\d+)$/) do |number|
  # Need to create the dice manually here...
  # Add to the game events model?
  # or change controller to accept number when in testing mode...
  step "I enter in #{number} as dice roll"
  step 'I roll the dice'
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
