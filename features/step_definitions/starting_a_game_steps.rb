WAITING_FOR_PLAYERS_SELECTOR = "#waiting_for_players"
WAITING_FOR_PLAYERS_REGEX    = /Waiting for (?<players>\d+) player(?:s)?/i

def waiting_for_players
  find(WAITING_FOR_PLAYERS_SELECTOR).text.gsub(WAITING_FOR_PLAYERS_REGEX, '\\k<players>')
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


When(/^I pick a piece$/) do
  step 'I select wheelbarrow as piece'
  step 'I click on "Create Player"'
end


Then(/^I should see a new player form$/) do
  expect(page).to have_current_path(new_game_player_path(game_id: 1), only_path: true)
end

Then(/^I should see a waiting for players page$/) do
  expect(page).to have_current_path(game_players_path(game_id: 1), only_path: true)
end

Then(/^I should be waiting for (\d+) more player(?:s)?$/) do |player_count|
  expect(waiting_for_players).to eq player_count
end
