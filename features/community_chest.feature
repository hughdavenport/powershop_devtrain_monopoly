Feature: Landing on community chest
  As a user
  I should be able to land on community chest and have various effects happen

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Landing on community chest
    Given It is my turn
    When I land on Community Chest
    Then I should be able to draw a card

  Scenario: Can't end turn before drawing card
    Given It is my turn
    When I land on Community Chest
    Then I should not be able to end my turn

  Scenario: Can't draw multiple cards
    Given It is my turn
    And I land on Community Chest
    When I draw a card
    Then I should not be able to draw a card

  Scenario: Going to Go
    Given It is my turn
    And I land on Community Chest
    When I draw "Advance to Go"
    Then I should be on Go
    And I should gain go money

  Scenario: Receiving money
    Given It is my turn
    And I land on Community Chest
    And I know my location
    When I draw "Bank error in your favour"
    Then I should gain $100
    And I should not move along the board

  Scenario: Giving money
    Given It is my turn
    And I land on Community Chest
    And I know my location
    When I draw "Doctor's fee"
    Then I should lose $50
    And I should not move along the board

  Scenario: Reshuffling the deck
    Given 17 community chest cards have been used
    And It is my turn
    When I land on Community Chest
    And I know my location
    Then I should be able to draw a card
