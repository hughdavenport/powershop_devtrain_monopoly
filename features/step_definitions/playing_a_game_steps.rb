DICE_ROLL_SELECTOR = '#diceroll'

When(/^I roll the dice$/) do
  step 'I click on "Roll Dice"'
end

Then(/^I should see a dice roll$/) do
  expect(page).to have_selector(DICE_ROLL_SELECTOR)
end
