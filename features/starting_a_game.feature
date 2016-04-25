Feature: Starting a game
  As a player
  I want to start a game of monopoly

  Background:
    Given I have a user

  Scenario: Navigating to the new player page
    Given I see the home page
    When I click on "New Game"
    Then I should see a new player form

  Scenario: Creating a new player
    Given I have started a new game
    When I pick a piece
    And I click on "Create"
    Then I should see a waiting for players page
    And there should be 1 player waiting

  Scenario: Joining a waiting game
    Given there is another user
    And they have started a game
    And they are waiting for a player
    When I join their game
    Then I should see their player and a waiting screen
    And there should be 2 players waiting

  Scenario: Starting a game
    Given I am waiting for more players
    And there is another user
    And they join my game
    When I click "Start Game"
    Then I should see a new game
    And there should be 2 players in the game
