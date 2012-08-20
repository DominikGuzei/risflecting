Feature: Accept an appointment
  In order to reserve my spot at an appointment
  As a user
  I want to show my acceptance

  Background:
    Given I am signed in as a user

  @javascript
  Scenario: Accept first appointment through appointments overview page
    Given there is an appointment
    When I visit the appointments overview page
    And I click on 'Zusagen'
    Then I want to get feedback that my acceptance succeeded

  @javascript
  Scenario: Accept second appointment through appointments overview page
    Given there are 2 appointments
    And I have already accepted 1 appointment
    When I visit the appointments overview page
    And I click on 'Zusagen'
    Then I want to see 2 appointments accepted
