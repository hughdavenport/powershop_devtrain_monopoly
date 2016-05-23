Feature: Landing on chance
  As a user
  I should be able to land on chance and have various effects happen

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Paying each player
    # TODO fine specimen for having 3 players
    Given It is my turn
    And I land on Chance
    When I draw "You have been elected Chairman of the board"
    Then I should lose $50

  Scenario: Checking other side gets the money for Pay each player cards
    # TODO fine specimen for having 3 players
    Given It is another users turn
    And another user lands on Chance
    When another user draws "You have been elected Chairman of the board"
    Then I should gain $50

  Scenario: House tax
    Given I completely own the brown set with 2 houses each
    And It is my turn
    And I land on Chance
    When I draw "Make general repairs on all your properties"
    # $25 * 4 houses
    Then I should lose $100

  Scenario: Hotel tax
    Given I completely own the blue set with a hotel each
    And It is my turn
    And I land on Chance
    When I draw "Make general repairs on all your properties"
    # $100 * 3
    Then I should lose $300

  Scenario: Mixture of house and hotel tax
    Given I completely own the pink set with 4 houses each
    And I completely own the orange set with 3 houses each
    And It is my turn
    And I buy a hotel for Pall Mall
    And I buy a house for Vine Street
    And I land on Chance
    When I draw "Make general repairs on all your properties"
    # $25 * (4*2 + 3*2 + 4) + $100 * 1 = $25 * 18 + $100 = $550
    Then I should lose $550
