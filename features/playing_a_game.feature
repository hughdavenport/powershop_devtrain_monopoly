Feature: Playing a game
  As a user
  I want to play a game of monopoly

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario:
    Given I go to the game
    When I roll the dice
    Then I should see a dice roll

