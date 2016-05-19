Feature: Rolling dice
  As a user
  I should see progress when rolling dice

  Background:
    Given I have a user
    And there is another user
    And I am in a game

  Scenario: Rolling a dice
    Given It is my turn
    When I roll the dice
    Then I should see a dice roll
    And I should not move along the board

  Scenario: Moving along the board
    Given It is my turn
    When I roll two dice
    Then I should move along the board

  Scenario: Changing turns
    Given It is my turn
    When I roll two dice (not doubles)
    And I end my turn
    Then It should not be my turn

  Scenario: Not allowed to roll
    Given It is my turn
    When I roll two dice (not doubles)
    Then I should not be able to roll the dice

  Scenario: Rolling a double
    Given It is my turn
    When I roll a double
    Then I should be able to roll the dice

  Scenario: Rolling three doubles
    Given It is my turn
    And I roll 2 doubles
    And I know my balance
    When I roll a double
    Then I should be in jail
    And It should not be my turn
    And I should gain $0

  Scenario: Rolling three doubles passing Go
    Given I am on Go
    And It is my turn
    And I roll a 10
    And I roll a 10
    # I should be on free parking
    And I know my location
    And I roll a 6
    And I roll a 6
    # I should be on oxford street
    And I know my location
    And I know my balance
    When I roll a 8
    And I roll a 8
    # I should be on euston road
    And I know my location
    Then I should be in jail
    And It should not be my turn
    And I should gain $0

  Scenario: Rolling three doubles landing on Go
    Given I am on Go
    And It is my turn
    And I roll a 10
    And I roll a 10
    # I should be on free parking
    And I know my location
    And I roll a 6
    And I roll a 6
    # I should be on oxford street
    And I know my location
    And I know my balance
    When I roll a 4
    And I roll a 4
    # I should be on Go
    And I know my location
    Then I should be in jail
    And It should not be my turn
    And I should gain $0

  Scenario: Rolling three doubles landing on Income tax
    Given I am on Go
    And It is my turn
    And I roll a 10
    And I roll a 10
    # I should be on free parking
    And I know my location
    And I roll a 10
    And I roll a 10
    # I should be on Go
    And I know my location
    And I know my balance
    When I roll a 2
    And I roll a 2
    # I should be on Income Tax
    And I know my location
    Then I should be in jail
    And It should not be my turn
    And I should lose $0

  Scenario: Rolling three doubles landing on Super tax
    Given I am on Go
    And It is my turn
    And I roll a 10
    And I roll a 10
    # I should be on free parking
    And I know my location
    And I roll a 6
    And I roll a 6
    # I should be on oxford street
    And I know my location
    And I know my balance
    When I roll a 3
    And I roll a 3
    # I should be on Super Tax
    And I know my location
    Then I should be in jail
    And It should not be my turn
    And I should lose $0

  Scenario: While in jail
    Given I am in jail
    And It is my turn
    When I roll two dice (not doubles)
    And I end my turn
    Then I should be in jail
    And It should not be my turn

  Scenario: Not allowed to roll in jail
    Given I am in jail
    And It is my turn
    When I roll two dice (not doubles)
    Then I should not be able to roll the dice

  Scenario: Breaking out of jail with doubles
    Given I am in jail
    And It is my turn
    When I roll a double
    Then I should be visiting jail
    And I should lose $0
    And It should not be my turn

  Scenario: Paying bond
    Given I am in jail for 2 turns
    And It is my turn
    When I roll two dice (not doubles)
    Then I should be visiting jail
    And I should lose $50
    And It should not be my turn
