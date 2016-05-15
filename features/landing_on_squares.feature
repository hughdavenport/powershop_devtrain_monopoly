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

  Scenario: Landing on go to jail
    Given It is my turn
    When I land on Go To Jail
    Then I should be in jail
    And It should not be my turn

  Scenario: Landing on a property
    Given It is my turn
    And Whitechapel road is not owned
    When I land on Whitechapel road
    And I click on "Buy Property"
    Then I should own Whitechapel road
    And I should lose $60
