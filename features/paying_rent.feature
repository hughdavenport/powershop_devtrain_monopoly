Feature: Paying rent
  As a user
  I should be able to pay rent in monopoly

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Landing on my property
    Given I own Whitechapel Road
    And It is my turn
    When I land on Whitechapel Road
    Then I should own Whitechapel Road
    And I should lose $0

  Scenario: Landing on another users property
    Given another user owns Whitechapel Road
    And It is my turn
    When I land on Whitechapel Road
    Then I should lose $4

  Scenario: Paying rent on a single utility
    Given another user owns Electric Company
    And It is my turn
    When I land on Electric Company
    And I roll the dice
    Then I should lose 4 times the dice roll

  Scenario: Paying rent for both utilities
    Given another user owns Electric Company
    And another user owns Water Works
    And It is my turn
    When I land on Electric Company
    And I roll the dice
    Then I should lose 10 times the dice roll

  Scenario: Paying rent on a single station
    Given another user owns Kings Cross Station
    And It is my turn
    When I land on Kings Cross Station
    Then I should lose $25

  Scenario: Paying rent on two stations
    Given another user owns Kings Cross Station
    And another user owns Marylbone Station
    And It is my turn
    When I land on Kings Cross Station
    Then I should lose $50

  Scenario: Paying rent on three stations
    Given another user owns Kings Cross Station
    And another user owns Marylbone Station
    And another user owns Fenchurch Street Station
    And It is my turn
    When I land on Kings Cross Station
    Then I should lose $100

  Scenario: Paying rent on all four stations
    Given another user owns Kings Cross Station
    And another user owns Marylbone Station
    And another user owns Fenchurch Street Station
    And another user owns Liverpool Street Station
    And It is my turn
    When I land on Kings Cross Station
    Then I should lose $200
