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
    And I buy the property
    Then I should own Whitechapel Road
    And I should lose $60

  Scenario: Can't afford property
    Given Whitechapel Road is not owned
    And I have $50
    When I land on Whitechapel Road
    Then I should not be able to buy the property

  Scenario: Not buying a property
    Given Whitechapel Road is not owned
    And It is my turn
    When I land on Whitechapel Road
    And TODO: Change this to start auction?
    And I end my turn
    Then Whitechapel Road should not be owned
    And I should lose $0
    And It should not be my turn

  Scenario: Can't buy property twice in a turn
    Given Whitechapel Road is not owned
    And It is my turn
    When I land on Whitechapel Road
    And I buy the property
    Then I should not be able to buy the property

  Scenario: Can't rebuy a property that is owned by me
    Given I own Whitechapel Road
    And It is my turn
    When I land on Whitechapel Road
    Then I should not be able to buy the property

  Scenario: Can't buy a property that is owned by someone else
    Given another user owns Whitechapel Road
    And It is my turn
    When I land on Whitechapel Road
    Then I should not be able to buy the property
