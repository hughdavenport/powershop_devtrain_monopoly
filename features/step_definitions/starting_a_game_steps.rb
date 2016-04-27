WAITING_FOR_PLAYERS_SELECTOR = "#waiting_for_players"
WAITING_FOR_PLAYERS_REGEX    = /^Waiting for (?<players>\d+) (?:player|players)$/i

PLAYERS_IN_GAME_SELECTOR     = "#players_in_game"
PLAYERS_IN_GAME_REGEX        = /^There are (?<players>\d+) (?:player|players) in the game$/i

def waiting_for_players
  find(WAITING_FOR_PLAYERS_SELECTOR).text.gsub(WAITING_FOR_PLAYERS_REGEX, '\\k<players>')
end

def players_in_game
  find(PLAYERS_IN_GAME_SELECTOR).text.gsub(PLAYERS_IN_GAME_REGEX, '\\k<players>')
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
