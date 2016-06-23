Feature: Bankruptsy
  As a player in monopoly
  I want to be able to go bankrupt

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Landing on Income Tax
    Given It is my turn
    And I have $190
    When I land on Income Tax
    Then I should be bankrupt

  Scenario: Landing on Super Tax
    Given It is my turn
    And I have $90
    When I land on Super Tax
    Then I should be bankrupt

  Scenario: Paying rent
    Given another user owns Mayfair
    And It is my turn
    And I have $1
    When I land on Mayfair
    Then I should be bankrupt

  Scenario: Paying chance money
    Given It is my turn
    And I have $12
    And I land on Chance
    And I know my location
    When I draw "Pay poor tax of $15"
    Then I should be bankrupt

  Scenario: Paying community chest money
    Given It is my turn
    And I have $30
    And I land on Community Chest
    And I know my location
    When I draw "Doctor's fee"
    Then I should be bankrupt

# TODO not yet implemented cards
# general repairs
# pay to all

# TODO also add another file for requiring to sell houses/mortgage things to stay in the game
