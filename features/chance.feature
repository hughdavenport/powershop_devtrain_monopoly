Feature: Landing on chance
  As a user
  I should be able to land on chance and have various effects happen

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Landing on chance
    Given It is my turn
    When I land on Chance
    Then I should be able to draw a card

  Scenario: Can't end turn before drawing card
    Given It is my turn
    When I land on Chance
    Then I should not be able to end my turn

  Scenario: Can't draw multiple cards
    Given It is my turn
    And I land on Chance
    When I draw a card
    Then I should not be able to draw a card

  Scenario: Going to Go
    Given It is my turn
    And I land on Chance
    When I draw "Advance to Go"
    Then I should be on Go
    And I should gain go money
