Feature: Edit project
  In order to correct type errors
  As a user
  I want to edit my project

  Background:
    Given I am signed in as a user

  Scenario: Project from a different user
    Given there is a project from another user
    And I am on the project details page
    Then I do not want to see a 'Bearbeiten' link

  Scenario: Access form through project details page
    Given there is a project of my own
    And I am on the project details page
    When I click on 'Bearbeiten'
    Then I want to see the form to edit the project

  Scenario: Change project information
    Given there is a project of my own
    And I am on the project edit page
    When I change the project´s title and description
    And I save the changes
    Then I want to see the changes on the project details page

  Scenario: Keep existing project information
    Given there is a project of my own
    And I am on the project edit page
    When I change none of the project information
    And I save the project anyway
    Then I want to see the existing project information on the project details page

  Scenario: Remove project information
    Given there is a project of my own
    And I am on the project edit page
    When I remove the project´s title and description
    And I save the changes
    Then I want to see 2 errors
