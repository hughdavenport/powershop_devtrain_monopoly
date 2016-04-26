WAITING_FOR_PLAYERS_SELECTOR = "#waiting_for_players"
WAITING_FOR_PLAYERS_REGEX    = /Waiting for (?<players>\d+) players/

# *VERY* basic login capability
def loginas(user)
  uri = URI.parse(current_url)
  query = URI.decode_www_form(uri.query ? uri.query : '').to_h
  query[:user] = user
  uri.query = URI.encode_www_form(query)
  visit uri.to_s
end

def waiting_for_players
  find('WAITING_FOR_PLAYERS_SELECTOR').text.gsub(WAITING_FOR_PLAYERS_REGEX, '\\k<players>')
end

Given(/^I have a user$/) do
  # TODO create a user model?
  # add params: user: blah to everything that involves this user
end

Given(/^there is another user$/) do
  # TODO create another user model
  # add params: user: blah to everything that involves this user
end

Given(/^I have started a new game(?: with (\d+) player(?:s))?$/) do |player_count|
  player_count = 2 unless player_count

  step 'I see the home page'
  step 'I click on "New Game"'
  step 'I enter in '"#{player_count}"' as number of players'
  step 'I click on "Create Game"'
end

Given(/^I am waiting for (\d+) more player(?:s)$/) do |player_count|
  step 'I have started a new game with '"#{player_count + 1}"' players'
  step 'I pick a piece'
end


When(/^I pick a piece$/) do
  step 'I select wheelbarrow as piece'
  step 'I click on "Create Player"'
end


Then(/^I should see a new player form$/) do
  expect(page).to have_current_path(new_game_player_path(game_id: 1))
end

Then(/^I should see a waiting for players page$/) do
  expect(page).to have_current_path(game_players_path(game_id: 1))
end

Then(/^I should be waiting for (\d+) more player(?:s)?$/) do |player_count|
  expect(waiting_for_players).to eq player_count
end
