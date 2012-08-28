# encoding: utf-8
Feature: Upload documents
  In order to share documents with all members
  As a coordinator
  I want to upload documents

  Scenario: Visit documents overview as a coordinator
    Given I am signed in as a coordinator
    And I am on the documents overview page
    When I click on 'neues Dokument hinzufügen'
    Then I want to see the form to upload documents

  Scenario: Submit form without filling any fields
    Given I am signed in as a coordinator
    And I am on the page with the document upload form
    When I leave all fields empty
    And I save the document
    Then I want to see 2 errors

  Scenario: Fill in all form fields and submit
    Given I am signed in as a coordinator
    And I am on the page with the document upload form
    When I choose a file to uplaod and fill in a title
    And I save the document
    Then I want to get feedback that the document was created successfully

  Scenario: Visit documents overview as a normal user
    Given I am signed in as a user
    And I am on the documents overview page
    Then I do not want to see the button to add a new document
