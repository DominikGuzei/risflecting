Feature: Delete appointments
  In order to keep the appointments up-to-date
  As an admin
  I want to delete appointments

  Background:
    Given there is an appointment

  @javascript
  Scenario: Delete appointment from the overview as an admin
    Given I am signed in as an admin
    And I am on the appointments overview page
    When I click on the trash bin icon
    And I confirm the upcoming dialog
    Then I want to get feedback that the appointment was deleted
    And I want the appointment to be removed from the list

  Scenario: As a user
    Given I am signed in as a user
    And I am on the appointments overview page
    Then I do not want to see a trash bin icon
