Feature: Running auctions
  As A player in monopoly
  I want to be able to run auctions when I don't purchase a property

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Not buying a property
    Given Whitechapel Road is not owned
    And It is my turn
    When I land on Whitechapel Road
    And TODO: Change this to start auction?
    And I end my turn
    Then Whitechapel Road should not be owned
    And I should lose $0
    And It should not be my turn
