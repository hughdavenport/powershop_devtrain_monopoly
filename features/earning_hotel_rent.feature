Feature: Earning rent on hotels
  As a user
  I should be able to earn rent on properties with hotels

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Earning normal house rent on non hotel, when others are hoteled
    Given I completely own the purple set with 4 houses each
    And Park Lane has a hotel
    And I know my balance
    And It is another users turn
    When another user lands on Mayfair
    Then I should gain $1700

  Scenario: Earning rent for one hotel
    Given I completely own the blue set with a hotel each
    And I know my balance
    And It is another users turn
    When another user lands on Whitechapel Road
    Then I should gain $450
