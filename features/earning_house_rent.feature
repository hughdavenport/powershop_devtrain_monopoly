Feature: Earning rent on houses
  As a user
  I should be able to earn rent on properties with houses

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Earning normal double rent on unimproved, when others are improved
    Given I completely own the yellow set
    And It is my turn
    And Leicester Square has 1 house
    And Piccadilly has 1 house
    And I know my balance
    And It is another users turn
    When another user lands on Coventry Street
    Then I should gain $44

  Scenario: Earning rent for one house
    Given I completely own the blue set with 1 house each
    And I know my balance
    And It is another users turn
    When another user lands on Pentonville Road
    Then I should gain $40

  Scenario: Earning rent for two houses
    Given I completely own the purple set with 2 houses each
    And I know my balance
    And It is another users turn
    When another user lands on Mayfair
    Then I should gain $600

  Scenario: Earning rent for three houses
    Given I completely own the pink set with 3 houses each
    And I know my balance
    And It is another users turn
    When another user lands on Pall Mall
    Then I should gain $450

  Scenario: Earning rent for four houses
    Given I completely own the green set with 4 houses each
    And I know my balance
    And It is another users turn
    When another user lands on Bond Street
    Then I should gain $1200
