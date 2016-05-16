Feature: Landing on squares
  As a user
  I should see outcomes when landing on squares

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Landing on Income Tax
    Given It is my turn
    When I land on Income Tax
    # This only tests the -$200, not the -15%
    And I should lose $200

  Scenario: Landing on Super Tax
    Given It is my turn
    When I land on Super Tax
    Then I should lose $100

  Scenario: Passing Go
    Given It is my turn
    When I pass Go
    Then I should gain $200

  Scenario: Landing on Go
    Given It is my turn
    When I land on Go
    Then I should gain $200

  Scenario: Landing on go to jail
    Given It is my turn
    When I land on Go To Jail
    Then I should be in jail
    And It should not be my turn

  Scenario: Buying a property
    Given Whitechapel Road is not owned
    And It is my turn
    When I land on Whitechapel Road
    And I click on "Buy property"
    Then I should own Whitechapel Road
    And I should lose $60
    And It should not be my turn

  Scenario: Can't afford property
    Given Whitechapel Road is not owned
    And I have $50
    When I land on Whitechapel Road
    Then I should not see "Buy property"

  Scenario: Landing on my property
    Given I own Whitechapel Road
    And It is my turn
    When I land on Whitechapel Road
    Then I should own Whitechapel Road
    And I should lose $0
    And It should not be my turn

  Scenario: Landing on another users property
    Given another user owns Whitechapel Road
    And It is my turn
    When I land on Whitechapel Road
    Then I should lose $4
    And It should not be my turn

  Scenario: Not buying a property
    Given Whitechapel Road is not owned
    And It is my turn
    When I land on Whitechapel Road
    And TODO: Change this to start auction?
    And I click on "End turn"
    Then Whitechapel Road should not be owned
    And I should lose $0
    And It should not be my turn
