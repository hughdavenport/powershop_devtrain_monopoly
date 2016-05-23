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

  Scenario: Going to trafalgar square
    Given It is my turn
    And I land on Chance
    When I draw "Advance to Trafalgar Square"
    Then I should be on Trafalgar Square

  Scenario: Going to trafalgar square passing go
    Given I am on Bond Street
    And It is my turn
    And I roll a 1
    And I roll a 1
    # I should be on chance before go
    When I draw "Advance to Trafalgar Square"
    Then I should be on Trafalgar Square
    And I should gain go money

  Scenario: Going to trafalgar square NOT passing go
    Given I am on Kings Cross Station
    And It is my turn
    And I roll a 1
    And I roll a 1
    # I should be on chance after go
    When I draw "Advance to Trafalgar Square"
    Then I should be on Trafalgar Square
    And I should not gain go money

  Scenario: Going to Pall Mall
    Given It is my turn
    And I land on Chance
    When I draw "Advance to Pall Mall"
    Then I should be on Pall Mall

  Scenario: Going to pall mall via go
    Given I am on Free Parking
    And It is my turn
    And I roll a 1
    And I roll a 1
    # I should be on Chance half way around
    When I draw "Advance to Pall Mall"
    Then I should be on Pall Mall
    And I should gain go money

  Scenario: Going to pall mall not via go
    Given I am on Kings Cross Station
    And It is my turn
    And I roll a 1
    And I roll a 1
    # I should be on chance after go
    When I draw "Advance to Pall Mall"
    Then I should be on Pall Mall
    And I should not gain go money

  Scenario: Going to Mayfair
    Given It is my turn
    And I land on Chance
    And I know my balance
    When I draw "Advance to Mayfair"
    Then I should be on Mayfair
    And I should not gain go money

  Scenario: Going to Marylebone Station
    Given It is my turn
    And I land on Chance
    When I draw "Take a trip to Marylebone Station"
    Then I should be on Marylebone Station

  Scenario: Going to Marylebone Station not via go
    Given I am on Kings Cross Station
    And It is my turn
    And I roll a 1
    And I roll a 1
    When I draw "Take a trip to Marylebone Station"
    Then I should be on Marylebone Station
    And I should not gain go money

  Scenario: Going to Marylebone Station via go
    Given I am on Free Parking
    And It is my turn
    And I roll a 1
    And I roll a 1
    When I draw "Take a trip to Marylebone Station"
    Then I should be on Marylebone Station
    And I should gain go money

  Scenario: Receiving money
    Given It is my turn
    And I land on Chance
    And I know my location
    When I draw "Bank pays you dividend of $50"
    Then I should gain $50
    And I should not move along the board

  Scenario: Giving money
    Given It is my turn
    And I land on Chance
    And I know my location
    When I draw "Pay poor tax of $15"
    Then I should lose $15
    And I should not move along the board

  Scenario: Moving back three spaces #1
    Given I am on Kings Cross Station
    And It is my turn
    And I roll a 1
    And I roll a 1
    # I should be on chance before go
    When I draw "Go Back 3 Spaces"
    Then I should be on Income Tax

  Scenario: Moving back three spaces #2
    Given I am on Free Parking
    And It is my turn
    And I roll a 1
    And I roll a 1
    # I should be on chance in the middle
    When I draw "Go Back 3 Spaces"
    Then I should be on Vine Street

  Scenario: Moving back three spaces #3
    Given I am on Bond Street
    And It is my turn
    And I roll a 1
    And I roll a 1
    # I should be on chance before go
    When I draw "Go Back 3 Spaces"
    Then I should be on Community Chest
