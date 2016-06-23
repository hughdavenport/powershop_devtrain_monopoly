Feature: Almost Bankruptsy
  As a player in monopoly
  I want to be able to not quite go bankrupt

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Landing on Income Tax
    Given It is my turn
    And I have $210
    When I land on Income Tax
    Then I should not be bankrupt
    And I should have $10 balance

  Scenario: Landing on Super Tax
    Given It is my turn
    And I have $110
    When I land on Super Tax
    Then I should not be bankrupt
    And I should have $10 balance

  Scenario: Paying rent
    Given another user owns Mayfair
    And It is my turn
    And I have $51
    When I land on Mayfair
    Then I should not be bankrupt
    And I should have $1 balance

  Scenario: Paying chance money
    Given It is my turn
    And I have $16
    And I land on Chance
    And I know my location
    When I draw "Pay poor tax of $15"
    Then I should not be bankrupt
    And I should have $1 balance

  Scenario: Paying community chest money
    Given It is my turn
    And I have $51
    And I land on Community Chest
    And I know my location
    When I draw "Doctor's fee"
    Then I should not be bankrupt
    And I should have $1 balance

  Scenario: Paying bond money
    Given I am in jail for 2 turns
    And It is my turn
    And I have $55
    When I roll two dice (not doubles)
    Then I should not be bankrupt
    And I should have $5 balance
