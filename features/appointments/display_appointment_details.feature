Feature: Appoinment details
  In order to catch up on an appointment
  As a user
  I want to view the details of an appointment

  Background:
    Given I am signed in as a user

  Scenario: View appointment
    Given there is an appointment
    And I am on the appointments overview page
    When I click on the title of the appointment
    Then I want to see the details of the appointment

  Scenario: Appointment is in the past
    Given there is a past appointment
    And I am on the appointment details page
    Then I do not want to see buttons to accept or reject
