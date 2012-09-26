Feature: Dashboard
  In order to have a rapid overview over recent events
  As a user
  I want to see recent and upcoming events on the dashboard

  Background:
    Given I am signed in as a user
    And there is an appointment
    And there is a question
    And there is a project
    And there is a document
    And I am on the Dashboard

  Scenario: Navigate to appointment details
    When I click on the title of the appointment
    Then I want to be on the appointment details page

  Scenario: Navigate to question details
    When I click on the title of the question
    Then I want to be on the question details page

  Scenario: Navigate to project details
    When I click on the title of the project
    Then I want to be on the project details page

  Scenario: Navigate to document details
    When I click on the title of the document
    Then I want to see the document
