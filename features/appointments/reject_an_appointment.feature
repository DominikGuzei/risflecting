Feature: Reject an appointment
  In order to show my unavailability for an appointment
  As a user
  I want to reject an appointment

  Background:
    Given I am signed in as a user

  @javascript
  Scenario: Reject first appointment through appointments overview page
    Given there is an appointment
    And I am on the appointments overview page
    When I click on 'Absagen'
    Then I want to get feedback that my rejection succeeded

  @javascript
  Scenario: Reject second appointment through appointments overview page
    Given there are 2 appointments
    And I have already rejected 1 appointment
    And I am on the appointments overview page
    When I click on 'Absagen'
    Then I want to see 2 appointments rejected
