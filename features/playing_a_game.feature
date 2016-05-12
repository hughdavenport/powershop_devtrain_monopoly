Feature: Playing a game
  As a user
  I want to play a game of monopoly

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Rolling a dice
    Given It is my turn
    When I roll the dice
    Then I should see a dice roll
    And I should not move along the board

  Scenario: Moving along the board
    Given It is my turn
    When I roll two dice
    Then I should move along the board

  Scenario: Changing turns
    Given It is my turn
    When I roll two dice (not doubles)
    Then It should not be my turn

  Scenario: Rolling a double
    Given It is my turn
    When I roll a double
    Then It should be my turn

  Scenario: Rolling three doubles
    Given It is my turn
    When I roll 3 doubles
    Then I should be in jail

  Scenario: While in jail
    Given I am in jail
    And It is my turn
    When I roll two dice (not doubles)
    Then I should be in jail

  Scenario: Breaking out of jail with doubles
    Given I am in jail
    And It is my turn
    When I roll a double
    Then I should be visiting jail
