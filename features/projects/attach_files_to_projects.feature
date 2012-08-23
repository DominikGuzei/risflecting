Feature: Attach files to projects
  In order to add more information to my project
  As a user
  I want to attach files

  Background:
    Given I am signed in as a user

  Scenario: View project from another user
    Given there is a project from another user
    And I am on the project details page
    Then I do not want to see the attachment upload form

  Scenario: View project of my own
    Given there is a project of my own
    And I am on the project details page
    Then I want to see the attachment upload form

  Scenario: Add an attachment to a project of my own
    Given there is a project of my own
    And I am on the project details page
    When I chose a file to add to the project
    And I upload the attachment
    Then I want some feedback that the attachment was successfully uploaded
    And I want to be on the project details page
