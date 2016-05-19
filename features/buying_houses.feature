Feature: Buying houses
  As a user
  I should be able to buy houses in monopoly

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Can't buy a house on not fully owned street
    Given Trafalgar Square is not owned
    And I own Strand
    And I own Fleet Street
    When It is my turn
    Then I should not be able to buy a house

  Scenario: Can buy a house for a fully owned street
    Given I completely own the red set
    When It is my turn
    Then I should be able to buy a house for Trafalgar Square

  Scenario: Cost of brown set
    Given I completely own the brown set
    And It is my turn
    When I buy a house for Old Kent Road
    Then Old Kent Road should have 1 house
    And I should lose $50

  Scenario: Cost of blue set
    Given I completely own the blue set
    And It is my turn
    When I buy a house for The Angel Islington
    Then The Angel Islington should have 1 house
    And I should lose $50

  Scenario: Cost of pink set
    Given I completely own the pink set
    And It is my turn
    When I buy a house for Pall Mall
    Then Pall Mall should have 1 house
    And I should lose $100

  Scenario: Cost of orange set
    Given I completely own the orange set
    And It is my turn
    When I buy a house for Marlborough Street
    Then Marlborough Street should have 1 house
    And I should lose $100

  Scenario: Cost of red set
    Given I completely own the red set
    And It is my turn
    When I buy a house for Trafalgar Square
    Then Trafalgar Square should have 1 house
    And I should lose $150

  Scenario: Cost of yellow set
    Given I completely own the yellow set
    And It is my turn
    When I buy a house for Piccadilly
    Then Piccadilly should have 1 house
    And I should lose $150

  Scenario: Cost of green set
    Given I completely own the green set
    And It is my turn
    When I buy a house for Bond Street
    Then Bond Street should have 1 house
    And I should lose $200

  Scenario: Cost of purple set
    Given I completely own the purple set
    And It is my turn
    When I buy a house for Park Lane
    Then Park Lane should have 1 house
    And I should lose $200

  Scenario: Can't build unevenly
    Given I completely own the red set
    And It is my turn
    And Fleet Street has 1 house
    When It is my turn
    Then I should not be able to buy a house for Fleet Street
    And I should be able to buy a house for Strand

  Scenario: Can build evenly
    Given I completely own the red set
    And It is my turn
    And the red set has 1 house each
    When It is my turn
    Then I should be able to buy a house

  Scenario: Can't buy a house when I can't afford
    Given I completely own the red set
    And I have $10
    When It is my turn
    Then I should not be able to buy a house

  Scenario: Buying a house for two fully owned streets
    Given I completely own the orange set
    And I completely own the yellow set
    And I have $300
    When It is my turn
    Then I should be able to buy a house for Bow Street
    And I should be able to buy a house for Coventry Street

  Scenario: Having two full streets, but only affording one
    Given I completely own the purple set
    And I completely own the brown set
    And I have $75
    When It is my turn
    Then I should not be able to buy a house for Mayfair
    And I should be able to buy a house for Old Kent Road

  Scenario: Can't buy a house after rolling the dice
    Given I completely own the blue set
    And It is my turn
    When I roll the dice
    Then I should not be able to buy a house

  Scenario: Can't buy a house if they are all used
    Given I completely own the red set
    And 32 houses are used
    When It is my turn
    Then I should not be able to buy a house

  Scenario: Can't buy a house for a set someone else has
    Given another user completely owns the brown set
    When It is my turn
    Then I should not be able to buy a house

  Scenario: Can't buy more than 4 houses
    Given I completely own the pink set with 4 houses each
    When It is my turn
    Then I should not be able to buy a house
