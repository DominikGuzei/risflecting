Feature: Accept an appointment
  In order to reserve my spot at an appointment
  As a user
  I want to show my acceptance

  Background:
    Given I am signed in as a user

  @javascript
  Scenario: Accept first appointment through appointments overview page
    Given there is an appointment
    And I am on the appointments overview page
    When I click on 'Teilnehmen'
    Then I want to get feedback that my acceptance succeeded

  @javascript
  Scenario: Accept second appointment through appointments overview page
    Given there are 2 appointments
    And I have already accepted 1 appointment
    And I am on the appointments overview page
    When I click on 'Teilnehmen'
    Then I want to see 2 appointments accepted
