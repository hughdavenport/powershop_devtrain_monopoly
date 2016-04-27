Feature: Starting a game
  As a player
  I want to start a game of monopoly

  Background:
    Given I have a user
    And there is another user

  Scenario: Navigating to the new player page
    Given I see the home page
    When I click on "New Game"
    And I enter in 2 as number of players
    And I click on "Create Game"
    Then I should be waiting for 2 players

  Scenario: Creating a new player
    Given I have started a new game with 2 players
    When I pick a piece
    Then I should see a waiting for players page
    And I should be waiting for 1 more player

  Scenario: Joining a waiting game
    Given another user is waiting for 1 more player
    When I join the game
    Then I should see the game

  Scenario: Joining a large waiting game
    Given another user is waiting for 2 more players
    When I join the game
    Then I should see a waiting for players page
    And I should be waiting for 1 more player

  Scenario: Starting a game
    Given I am waiting for 1 more player
    And another user joins the game
    When I go to the game
    Then I should see the game
    And there should be 2 players in the game

  Scenario: Waiting for multiple players
    Given I am waiting for 2 more players
    And another user joins the game
    When I go to the game
    Then I should see a waiting for players page
    And I should be waiting for 1 more player
