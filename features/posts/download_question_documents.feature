Feature: Download question documents
  In order to view the additional question documents
  As a user
  I want to download the documents from the question's detail page

  Background:
    Given I am signed in as a user
    Given there is a question

  Scenario: Display file list
    Given the question has 2 attached files
    And I am on the question details page
    Then I want to see a list containing 2 linked file names

  Scenario: Download from file list on question details page
    Given the question has 1 attached file
    And I am on the question details page
    When I click on the filename in the attachments section
    Then I want to receive a file
