Feature: Mortgaging property
  As a user
  I should be able to mortgage properties in monopoly

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Ability to mortgage a property
    Given I own Whitechapel Road
    When It is my turn
    Then I should be able to mortgage Whitechapel Road

  Scenario: Ability to mortgage two properties
    Given I own Whitechapel Road
    And I own Fleet Street
    When It is my turn
    Then I should be able to mortgage Whitechapel Road
    And I should be able to mortgage Fleet Street

  Scenario: Non-Ability to mortgage a property
    Given It is my turn
    Then I should not be able to mortgage

  Scenario: Getting money back for brown
    Given I own Whitechapel Road
    And It is my turn
    When I mortgage Whitechapel Road
    Then I should gain $30
    And Whitechapel Road should be mortgaged

  Scenario: Getting money back for yellow
    Given I own Piccadilly
    And It is my turn
    When I mortgage Piccadilly
    Then I should gain $140
    And Piccadilly should be mortgaged

  Scenario: Can't mortgage twice
    Given I have mortgaged Bow Street
    When It is my turn
    Then I should not be able to mortgage Bow Street

  Scenario: Ability to unmortgage
    Given I have mortgaged Park Lane
    When It is my turn
    Then I should be able to unmortgage Park Lane

  Scenario: Ability to unmortgage two properties
    Given I have mortgaged Whitechapel Road
    And I have mortgaged Fleet Street
    When It is my turn
    Then I should be able to unmortgage Whitechapel Road
    And I should be able to unmortgage Fleet Street

  Scenario: Non-Ability to unmortgage a property when none owned
    Given It is my turn
    Then I should not be able to unmortgage

  Scenario: Non-Ability to unmortgage a property when some owned
    Given I own Mayfair
    And It is my turn
    Then I should not be able to unmortgage

  Scenario: Can't buy houses on mortgaged properties
    Given I completely own the pink set
    And Pall Mall is mortgaged
    When It is my turn
    Then I should not be able to buy a house for Pall Mall
    And I should be able to buy a house for Whitehall

  Scenario: Can't mortgage properties with houses on it
    Given I completely own the green set with 2 houses each
    When It is my turn
    Then I should not be able to mortgage Bond Street

  Scenario: Can't mortgage properties with houses anywhere on block
    Given I completely own the purple set
    And Mayfair has 1 house
    When It is my turn
    Then I should not be able to mortgage Park Lane

  Scenario: Can't mortgage properties with hotels on it
    Given I completely own the blue set with a hotel each
    When It is my turn
    Then I should not be able to mortgage Euston Road

  Scenario: Paying for unmortgage for green
    Given I have mortgaged Oxford Street
    And It is my turn
    When I unmortgage Oxford Street
    Then I should lose $150
    And Oxford Street should be unmortgaged

  Scenario: Getting money back for blue
    Given I have mortgaged The Angel Islington
    And It is my turn
    When I unmortgage The Angel Islington
    Then I should lose $50
    And The Angel Islington should be unmortgaged

  Scenario: Can't earn rent on mortgaged properties
    Given I have mortgaged Whitehall
    And I know my balance
    And It is another users turn
    When another user lands on Whitehall
    Then I should gain $0

  Scenario: Still get double rent for all colour group
    Given I completely own the brown set
    And Old Kent Road is mortgaged
    And I know my balance
    And It is another users turn
    When another user lands on Whitechapel Road
    Then I should gain $4
