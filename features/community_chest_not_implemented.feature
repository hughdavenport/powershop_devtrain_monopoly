Feature: Landing on community chest
  As a user
  I should be able to land on community chest and have various effects happen

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Collecting from each player
    # TODO fine specimen for having 3 players
    Given It is my turn
    And I land on Community Chest
    When I draw "Grand Opera Night"
    Then I should gain $50

  Scenario: Checking other side gets the money for Collect each player cards
    # TODO fine specimen for having 3 players
    Given It is another users turn
    And another user lands on Community Chest
    When another user draws "Grand Opera Night"
    Then I should lose $50

  Scenario: House tax
    Given I completely own the brown set with 2 houses each
    And It is my turn
    And I land on Community Chest
    When I draw "You are assessed for street repairs"
    # $40 * 4 houses
    Then I should lose $160

  Scenario: Hotel tax
    Given I completely own the blue set with a hotel each
    And It is my turn
    And I land on Community Chest
    When I draw "You are assessed for street repairs"
    # $115 * 3
    Then I should lose $345

  Scenario: Mixture of house and hotel tax
    Given I completely own the pink set with 4 houses each
    And I completely own the orange set with 3 houses each
    And It is my turn
    And I buy a hotel for Pall Mall
    And I buy a house for Vine Street
    And I land on Community Chest
    When I draw "You are assessed for street repairs"
    # $40 * (4*2 + 3*2 + 4) + $115 * 1 = $40 * 18 + $115 = $835
    Then I should lose $835
