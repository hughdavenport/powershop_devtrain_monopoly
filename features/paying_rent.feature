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

  Scenario: Paying rent for a single utility when I own the other one
    Given another user owns Water Works
    And I own Electric Company
    And It is my turn
    When I land on Water Works
    And I roll the dice
    Then I should lose 4 times the dice roll

  Scenario: Paying rent on a single station
    Given another user owns Kings Cross Station
    And It is my turn
    When I land on Kings Cross Station
    Then I should lose $25

  Scenario: Paying rent on two stations
    Given another user owns Kings Cross Station
    And another user owns Marylebone Station
    And It is my turn
    When I land on Kings Cross Station
    Then I should lose $50

  Scenario: Paying rent on three stations
    Given another user owns Kings Cross Station
    And another user owns Marylebone Station
    And another user owns Fenchurch Street Station
    And It is my turn
    When I land on Kings Cross Station
    Then I should lose $100

  Scenario: Paying rent on all four stations
    Given another user owns Kings Cross Station
    And another user owns Marylebone Station
    And another user owns Fenchurch Street Station
    And another user owns Liverpool Street Station
    And It is my turn
    When I land on Kings Cross Station
    Then I should lose $200

  Scenario: Paying rent on two stations when I own the other two
    Given another user owns Kings Cross Station
    And another user owns Marylebone Station
    And I own Fenchurch Street Station
    And I own Liverpool Street Station
    And It is my turn
    When I land on Marylebone Station
    Then I should lose $50

  Scenario: Paying rent for an entire colour group (size 3)
    Given another user owns The Angel Islington
    And another user owns Euston Road
    And another user owns Pentonville Road
    And It is my turn
    When I land on Euston Road
    Then I should lose $12

  Scenario: Paying rent for an entire colour group (size 2)
    Given another user owns Park Lane
    And another user owns Mayfair
    And It is my turn
    When I land on Mayfair
    Then I should lose $100

  Scenario: Paying rent on an almost entire colour group (size 3)
    Given another user owns Bow Street
    And another user owns Vine Street
    And I own Marlborough Street
    And It is my turn
    When I land on Vine Street
    Then I should lose $16

  Scenario: Paying rent on an almost entire colour group (size 2)
    Given another user owns Old Kent Road
    And I own Whitechapel Road
    And It is my turn
    When I land on Old Kent Road
    Then I should lose $2
