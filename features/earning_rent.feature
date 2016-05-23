Feature: Earning rent
  As a user
  I should be able to receive rent in monopoly

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Another user owes rent
    Given I own Park Lane
    And I know my balance
    And It is another users turn
    When another user lands on Park Lane
    Then I should gain $35

  Scenario: Earning rent on a single utility
    Given I own Electric Company
    And I know my balance
    And It is another users turn
    When another user lands on Electric Company
    And another user rolls the dice
    Then I should gain 4 times the dice roll

  Scenario: Earning rent for both utilities
    Given I own Electric Company
    And I own Water Works
    And I know my balance
    And It is another users turn
    When another user lands on Electric Company
    And another user rolls the dice
    Then I should gain 10 times the dice roll

  Scenario: Earning rent for a single utility when I own the other one
    Given I own Water Works
    And I know my balance
    And another user owns Electric Company
    And It is another users turn
    When another user lands on Water Works
    And another user rolls the dice
    Then I should gain 4 times the dice roll

  Scenario: Earning rent on a single station
    Given I own Kings Cross Station
    And I know my balance
    And It is another users turn
    When another user lands on Kings Cross Station
    Then I should gain $25

  Scenario: Earning rent on two stations
    Given I own Kings Cross Station
    And I own Marylebone Station
    And I know my balance
    And It is another users turn
    When another user lands on Kings Cross Station
    Then I should gain $50

  Scenario: Earning rent on three stations
    Given I own Kings Cross Station
    And I own Marylebone Station
    And I own Fenchurch Street Station
    And I know my balance
    And It is another users turn
    When another user lands on Kings Cross Station
    Then I should gain $100

  Scenario: Earning rent on all four stations
    Given I own Kings Cross Station
    And I own Marylebone Station
    And I own Fenchurch Street Station
    And I own Liverpool Street Station
    And I know my balance
    And It is another users turn
    When another user lands on Kings Cross Station
    Then I should gain $200

  Scenario: Earning rent on two stations when I own the other two
    Given I own Kings Cross Station
    And I own Marylebone Station
    And I know my balance
    And another user owns Fenchurch Street Station
    And another user owns Liverpool Street Station
    And It is another users turn
    When another user lands on Marylebone Station
    Then I should gain $50

  Scenario: Earning rent for an entire colour group (size 3)
    Given I own The Angel Islington
    And I own Euston Road
    And I own Pentonville Road
    And I know my balance
    And It is another users turn
    When another user lands on Euston Road
    Then I should gain $12

  Scenario: Earning rent for an entire colour group (size 2)
    Given I own Park Lane
    And I own Mayfair
    And I know my balance
    And It is another users turn
    When another user lands on Mayfair
    Then I should gain $100

  Scenario: Earning rent on an almost entire colour group (size 3)
    Given I own Bow Street
    And I own Vine Street
    And I know my balance
    And another user owns Marlborough Street
    And It is another users turn
    When another user lands on Vine Street
    Then I should gain $16

  Scenario: Earning rent on an almost entire colour group (size 2)
    Given I own Old Kent Road
    And I know my balance
    And another user owns Whitechapel Road
    And It is another users turn
    When another user lands on Old Kent Road
    Then I should gain $2
