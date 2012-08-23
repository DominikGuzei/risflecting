Feature: Download project documents
  In order to view the additional project documents
  As a user
  I want to download the documents from the project´s detail page

  Background:
    Given I am signed in as a user
    Given there is a project

  Scenario: Display file list
    Given the project has 2 attached files
    And I am on the project details page
    Then I want to see a list containing 2 linked file names

  Scenario: Download from file list on project details page
    Given the project has 1 attached file
    And I am on the project details page
    When I click on the filename in the attachments section
    Then I want to receive a file
