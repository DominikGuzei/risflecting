Feature: Edit appointment
  In order to react upon changes
  As an admin
  I want to edit an appointment

  Background:
    Given there is an appointment

  Scenario: As a user
    Given I am signed in as a user
    And I am on the appointment details page
    Then I should not see a 'Termin bearbeiten' link

  Scenario: Navigate to edit form as admin
    Given I am signed in as an admin
    And I am on the appointment details page
    When I click on 'Termin bearbeiten'
    Then I want to see the form to edit the appointment

  Scenario: Change appointment information
    Given I am signed in as an admin
    And I am on the appointment edit page
    When I change the title, description, location and time
    And I save the changes
    Then I want to see the changes on the appointment details page

  Scenario: Keep existing appointment information
    Given I am signed in as an admin
    And I am on the appointment edit page
    When I change none of the appointment information
    And I safe the appointment anyway
    Then I wan to see the existing appointment information on the appointment details page

  Scenario: Remove appointment information
    Given I am signed in as an admin
    And I am on the appointment edit page
    When I remove the title and location
    And I save the changes
    Then I want to see 2 errors
