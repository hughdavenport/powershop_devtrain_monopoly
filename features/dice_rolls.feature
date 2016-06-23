Feature: Rolling dice
  As a user
  I should see progress when rolling dice

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
    And I end my turn
    Then It should not be my turn

  Scenario: Not allowed to roll
    Given It is my turn
    When I roll two dice (not doubles)
    Then I should not be able to roll the dice

  Scenario: Rolling a double
    Given It is my turn
    When I roll a double
    # TODO this can fail when we need to draw a card
    Then I should be able to roll the dice

  Scenario: Can't end turn before rolling
    Given It is my turn
    Then I should not be able to end my turn
