Feature: Change acceptance/rejection status
  In order to change my accepting/rejecting status for an appointment
  As a user
  I want to switch my status between acceptance and rejection

  Background:
    Given I am signed in as a user
    And there is an appointment

  @javascript
  Scenario: Switch from acceptance to rejection on appointments overview page
    Given I have already accepted 1 appointment
    When I visit the appointments overview page
    And I click on 'Absagen'
    Then I want to get feedback that my rejection succeeded
    And I want to see 1 appointment rejected

  @javascript
  Scenario: Switch from rejection to acceptance on appointments overview page
    Given I have already rejected 1 appointment
    When I visit the appointments overview page
    And I click on 'Zusagen'
    Then I want to get feedback that my acceptance succeeded
    And I want to see 1 appointment accepted

  Scenario: Switch from acceptance to rejection on appointment details page
    Given I have already accepted 1 appointment
    When I visit the appointment details page
    And I click on 'Absagen'
    Then I want to get feedback that my rejection succeeded

  Scenario: Switch from rejection to acceptance on appointment details page
    Given I have already rejected 1 appointment
    When I visit the appointment details page
    And I click on 'Zusagen'
    Then I want to get feedback that my acceptance succeeded
