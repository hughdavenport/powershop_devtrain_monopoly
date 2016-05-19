Feature: Paying rent on houses
  As a user
  I should be able to pay rent on properties with houses

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Paying normal double rent on unimproved, when others are improved
    Given another user completely owns the yellow set
    And It is another users turn
    And Leicester Square has 1 house
    And Piccadilly has 1 house
    And It is my turn
    When I land on Coventry Street
    Then I should lose $44

  Scenario: Paying rent for one house
    Given another user completely owns the blue set
    And It is another users turn
    And the blue set has 1 house each
    And It is my turn
    When I land on Pentonville Road
    Then I should lose $40

  Scenario: Paying rent for two houses
    Given another user completely owns the purple set
    And It is another users turn
    And the purple set has 2 house each
    And It is my turn
    When I land on Mayfair
    Then I should lose $600

  Scenario: Paying rent for three houses
    Given another user completely owns the pink set
    And It is another users turn
    And the pink set has 3 house each
    And It is my turn
    When I land on Pall Mall
    Then I should lose $450

  Scenario: Paying rent for four houses
    Given another user completely owns the green set
    And It is another users turn
    And the green set has 4 house each
    And It is my turn
    When I land on Bond Street
    Then I should lose $1200
