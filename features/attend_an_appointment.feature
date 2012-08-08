Feature: Attend an appointment
  In order to reserve my spot at an appointment
  As a user
  I want to show my attendance

  Background:
    Given I am signed in as a user
    And there is an appointment

  Scenario: Attend appointment through appointments overview page
    Given I am on the appointments overview page
    When I click on 'Teilnehmen'
    # Then I want to get feedback that my attendance was accepted
