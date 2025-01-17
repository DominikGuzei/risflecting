Feature: Limit access to appointment creation
  In order to have control over which appointments get created
  As an admin
  I want to be the only one who can create, delete and edit appointments

  Scenario: As an user
    Given I am signed in as a user
    And I am on the appointments overview page
    Then I do not want to see a link to create a new appointment
