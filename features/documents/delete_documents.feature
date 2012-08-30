Feature: Delete Documents
  In order to keep documents up-to-date
  As a coordinator
  I want to delete a document

  Background:
    Given there is a document

  @javascript
  Scenario: Delete document from documents overview
    Given I am signed in as a coordinator
    And I am on the documents overview page
    When I click on the trash bin icon
    And I confirm the upcoming dialog
    Then I want to get feedback that the document was deleted
    And I want the document to be removed from the list

  Scenario: As a user
    Given I am signed in as a user
    And I am on the documents overview page
    Then I do not want to see a trash bin icon
