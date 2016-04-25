Given(/^I have a user$/) do
  # TODO create a user model?
  # add params: user: blah to everything that involves this user
end

Given(/^there is another user$/) do
  # TODO create another user model
  # add params: user: blah to everything that involves this user
end

Given(/^I have started a new game$/) do
  step "I see the home page"
  step "I click on \"New Game\""
end

Given(/^I am waiting for more players$/) do
  step "I have started a new game"
  step "I pick a piece"
  step "I click on \"Create\""
end
