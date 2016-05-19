Feature: Paying rent on hotels
  As a user
  I should be able to pay rent on properties with hotels

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Paying normal hotel rent on non hotels, when others are improved
    Given another user completely owns the pink set with 4 houses each
    And Whitehall has a hotel
    And Northumberland Avenue has a hotel
    And It is my turn
    When I land on Pall Mall
    Then I should lose $625

  Scenario: Paying rent for one hotel
    Given another user completely owns the orange set with a hotel each
    And It is my turn
    When I land on Vine Street
    Then I should lose $1000
