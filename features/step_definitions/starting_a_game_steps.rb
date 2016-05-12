WAITING_FOR_PLAYERS_SELECTOR = "#waiting_for_players"
WAITING_FOR_PLAYERS_REGEX    = /^Waiting for (?<players>\d+) (?:player|players)$/i

PLAYERS_IN_GAME_SELECTOR     = "#players_in_game"
PLAYERS_IN_GAME_REGEX        = /^There are (?<players>\d+) (?:player|players) in the game$/i

BALANCE_SELECTOR             = "#balance"
BALANCE_REGEX                = /^Your balance is \$(?<amount>\d+)$/i

CURRENT_LOCATION_SELECTOR    = "#current_location"
CURRENT_LOCATION_REGEX       = /^You are at (?<location>.*)$/i

CURRENT_PLAYER_SELECTOR      = "#current_player"

def waiting_for_players
  find(WAITING_FOR_PLAYERS_SELECTOR).text.gsub(WAITING_FOR_PLAYERS_REGEX, '\\k<players>')
end

def players_in_game
  find(PLAYERS_IN_GAME_SELECTOR).text.gsub(PLAYERS_IN_GAME_REGEX, '\\k<players>')
end

def balance
  find(BALANCE_SELECTOR).text.gsub(BALANCE_REGEX, '\\k<amount>')
end

def current_location
  find(CURRENT_LOCATION_SELECTOR).text.gsub(CURRENT_LOCATION_REGEX, '\\k<location>')
end

Given(/^(I|another user) (?:have|has) started a new game(?: with (\d+) (?:player|players))$/) do |user, player_count|
  player_count = 2 unless player_count

  # First step will login as user
  step "#{user} sees the home page"
  step 'I click on "New Game"'
  step 'I enter in '"#{player_count}"' as number of players'
  step 'I click on "Create Game"'
end

Given(/^(I|another user) (?:am|is) waiting for (\d+) more (?:player|players)$/) do |user, player_count|
  # First step will login as user
  step "#{user} has started a new game with #{player_count.to_i + 1} players"
  step "I pick a piece"
end

Given(/^I am in a game(?: with (\d+) players)?$/) do |player_count|
  player_count = player_count ? player_count.to_i : 2
  step "I am waiting for #{player_count - 1} more players"
  (player_count - 1).times { step 'another user joins the game' }
  step 'I go to the game'
end


When(/^(I|another user) (?:pick|picks) a piece$/) do |user|
  step 'I click on "New Player"'
  # Choose the top piece
  step 'I click on "Create Player"'
end

When(/^(I|another user) (?:go|goes) to the game$/) do |user|
  # First step will login as user
  step "#{user} sees the home page"
  step 'I click on "List Games"'
  step 'I click on "Show"'
end

When(/^(I|another user) (?:join|joins) the game$/) do |user|
  # First step will login as user
  step "#{user} goes to the game"
  step 'I pick a piece'
end


Then(/^I should see a waiting for players page$/) do
  expect(page).to have_current_path(game_players_path(game_id: 1), only_path: true)
end

Then(/^I should see the game$/) do
  expect(page).to have_current_path(game_path(id: 1), only_path: true)
end

Then(/^I should be waiting for (\d+) (?:more )?(?:player|players)$/) do |player_count|
  expect(waiting_for_players).to eq player_count
end

Then(/^there should be (\d+) (?:player|players) in the game$/) do |player_count|
  expect(players_in_game).to eq player_count
end

Then(/^(I|another user) should have \$(\d+) balance$/) do |user, amount|
  # First step will login as user
  step "#{user} goes to the game"
  expect(balance).to eq amount
end

Then(/^(I|another user) should be the current player$/) do |user|
  # First step will login as user
  step "#{user} goes to the game"
  expect(page).to have_selector(CURRENT_PLAYER_SELECTOR)
end

Then(/^(I|another user) should( not)? be on (.*)$/) do |user, negation, location|
  step "#{user} goes to the game"
  if negation
    expect(current_location.downcase).not_to eq location.downcase
  else
    expect(current_location.downcase).to eq location.downcase
  end
end
