Feature: List documents
  In order to access all documents
  As a user
  I want to download documents from a list

  Background:
    Given I am signed in as a user

  Scenario: Navigate to documents overview through main navigation
    Given I am on the Dashboard
    And there are 3 documents
    When I navigate to 'Dokumente' through the main navigation
    Then I want to be on the documents overview page
    And I want to see 3 documents listed

  Scenario: Download a document using the download button
    Given there is a document
    And I am on the documents overview page
    When I click on 'Download'
    Then I want to receive a file

  Scenario: Download a document using the download button
    Given there is a document
    And I am on the documents overview page
    When I click on the document´s title
    Then I want to receive a file
