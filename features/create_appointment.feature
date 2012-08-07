Feature: Create Appointment
  In order to inform the community about a meeting
  As an admin
  I want to create a new appointment

  Background: Signed in user
    Given I am sign in as a user

  @javascript
  Scenario: Fill all fields in
    Given I visit the form to create a new appointment
    When I fill in all fields
    And I save the appointment
    Then I want some feedback that the appointment was created successfully
    And I want to see the newly created appointment

  Scenario: Leave all fields empty
    Given I visit the form to create a new appointment
    When I leave all fields empty
    And I save the appointment
    Then I want to see 4 errors
