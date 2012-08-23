Feature: List projects
  In order to get an overview of projects
  As a user
  I want to see all projects in a list

  Background:
    Given I am signed in as a user

  Scenario: List all projects
    Given there are 5 projects
    And I am on the projects page
    Then I want to see a list of 5 projects

  Scenario: Display title and author of each project in the list
    Given there is a project
    And I am on the Dashboard
    When I navigate to 'Tatenbank' through the main navigation
    Then I want to see the title and author of the project
