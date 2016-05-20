Feature: Buying hotels
  As a user
  I should be able to buy hotels in monopoly

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Can't buy a hotel on not fully owned street
    Given Trafalgar Square is not owned
    And I own Strand
    And I own Fleet Street
    When It is my turn
    Then I should not be able to buy a hotel

  Scenario: Can't buy a hotel on a not fully built (4 houses) street
    Given I completely own the brown set with 3 houses each
    When It is my turn
    Then I should not be able to buy a hotel

  Scenario: Can buy a hotel for a fully owned and built street
    Given I completely own the orange set with 4 houses each
    When It is my turn
    Then I should be able to buy a hotel for Vine Street

  Scenario: Cost of brown set
    Given I completely own the brown set with 4 houses each
    And It is my turn
    When I buy a hotel for Old Kent Road
    Then Old Kent Road should have a hotel
    And I should lose $50

  Scenario: Cost of blue set
    Given I completely own the blue set with 4 houses each
    And It is my turn
    When I buy a hotel for The Angel Islington
    Then The Angel Islington should have a hotel
    And I should lose $50

  Scenario: Cost of pink set
    Given I completely own the pink set with 4 houses each
    And It is my turn
    When I buy a hotel for Pall Mall
    Then Pall Mall should have a hotel
    And I should lose $100

  Scenario: Cost of orange set
    Given I completely own the orange set with 4 houses each
    And It is my turn
    When I buy a hotel for Marlborough Street
    Then Marlborough Street should have a hotel
    And I should lose $100

  Scenario: Cost of red set
    Given I completely own the red set with 4 houses each
    And It is my turn
    When I buy a hotel for Trafalgar Square
    Then Trafalgar Square should have a hotel
    And I should lose $150

  Scenario: Cost of yellow set
    Given I completely own the yellow set with 4 houses each
    And It is my turn
    When I buy a hotel for Piccadilly
    Then Piccadilly should have a hotel
    And I should lose $150

  Scenario: Cost of green set
    Given I completely own the green set with 4 houses each
    And It is my turn
    When I buy a hotel for Bond Street
    Then Bond Street should have a hotel
    And I should lose $200

  Scenario: Cost of purple set
    Given I completely own the purple set with 4 houses each
    And It is my turn
    When I buy a hotel for Park Lane
    Then Park Lane should have a hotel
    And I should lose $200

  Scenario: Can't build unevenly
    Given I completely own the red set with 3 houses each
    And It is my turn
    And Fleet Street has 1 more house
    When It is my turn
    Then I should not be able to buy a hotel for Fleet Street
    And I should be able to buy a hotel for Strand

  Scenario: Can't buy a hotel when I can't afford
    Given I completely own the red set with 4 houses each
    And I have $10
    When It is my turn
    Then I should not be able to buy a hotel

  Scenario: Buying a hotel for two fully built streets
    Given I completely own the orange set with 4 houses each
    And I completely own the yellow set with 4 houses each
    And I have $300
    When It is my turn
    Then I should be able to buy a hotel for Bow Street
    And I should be able to buy a hotel for Coventry Street

  Scenario: Having two fully built streets, but only affording one
    Given I completely own the purple set with 4 houses each
    And I completely own the brown set with 4 houses each
    And I have $75
    When It is my turn
    Then I should not be able to buy a hotel for Mayfair
    And I should be able to buy a hotel for Old Kent Road

  Scenario: Can't buy a hotel after rolling the dice
    Given I completely own the blue set with 4 houses each
    And It is my turn
    When I roll the dice
    Then I should not be able to buy a hotel

  Scenario: Can't buy a hotel if they are all used
    Given I completely own the red set with 4 houses each
    And 12 hotels are used
    When It is my turn
    Then I should not be able to buy a hotel

  Scenario: Can't buy a hotel for a set someone else has
    Given another user completely owns the brown set with 4 houses each
    When It is my turn
    Then I should not be able to buy a hotel

  Scenario: Can't buy more than one hotel
    Given I completely own the yellow set with a hotel each
    When It is my turn
    Then I should not be able to buy a hotel
