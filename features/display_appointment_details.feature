Feature: Appoinment details
  In order to catch up on an appointment
  As a user
  I want to view the details of an appointment

  Background:
    Given there is an appointment

  Scenario: View appointment
    Given I am on the appointments overview
    When I click on 'Details'
    Then I want to see the details of an appointment
