Feature: Starting a game
  As a player
  I want to start a game of monopoly

  Background:
    Given I have a user

  Scenario: Navigating to the new player page
    Given I see the home page
    When I click on "New Game"
    And I enter in 2 as number of players
    And I click on "Create Game"
    Then I should see a new player form

  Scenario: Creating a new player
    Given I have started a new game with 2 players
    When I pick a piece
    And I click on "Create"
    Then I should see a waiting for players page
    And I should be waiting for 1 more player

  Scenario: Joining a waiting game
    Given there is another user
    And they are waiting for 1 more player
    When I join their game
    Then I should see the game

  Scenario: Joining a large waiting game
    Given there is another user
    And they are waiting for 2 more players
    When I join their game
    Then I should see a waiting for players page
    And I should be waiting for 1 more player

  Scenario: Starting a game
    Given I am waiting for 1 more player
    And there is another user
    And they join my game
    When I go to the game
    Then I should see the game
    And there should be 2 players in the game

  Scenario: Waiting for multiple players
    Given I am waiting for 2 more players
    And there is another user
    And they join my game
    When I go to the game
    Then I should see a waiting for players page
    And I should be waiting for 1 more player