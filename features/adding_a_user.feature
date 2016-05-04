Feature: Adding a user
  As a admin
  I want to add a user to the system

  Scenario: Navigating to the new user page
    Given I see the home page
    When I click on "New User"
    And I enter in testingusername as username
    And I click on "Create User"
    Then I should see the content testingusername
