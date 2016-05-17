Feature: Buying property
  As a user
  I should be able to buy properties in monopoly

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Buying a property
    Given Whitechapel Road is not owned
    And It is my turn
    When I land on Whitechapel Road
    And I click on "Buy property"
    Then I should own Whitechapel Road
    And I should lose $60

  Scenario: Can't afford property
    Given Whitechapel Road is not owned
    And I have $50
    When I land on Whitechapel Road
    Then I should not see "Buy property"

  Scenario: Not buying a property
    Given Whitechapel Road is not owned
    And It is my turn
    When I land on Whitechapel Road
    And TODO: Change this to start auction?
    And I click on "End turn"
    Then Whitechapel Road should not be owned
    And I should lose $0
    And It should not be my turn
