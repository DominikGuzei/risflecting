Feature: Delete project attachments
  In order to get rid of out-dated attachments
  As a user
  I want to delete attachments from my project

  Background:
    Given I am signed in as a user

  Scenario: Project from myself
    Given there is a project of my own
    And the project has 1 attached file
    And I am on the project details page
    Then I want to see a trash bin next to the attachment

  Scenario: Project from different user
    Given there is a project from another user
    And the project has 1 attached file
    And I am on the project details page
    Then I do not want to see a trash bin next to the attachment

  @javascript
  Scenario: Delete attachment from a project from myself
    Given there is a project of my own
    And the project has 1 attached file
    And I am on the project details page
    When I click the trash bin next to the attachment
    And I confirm the upcoming dialog
    Then I want to get feedback that the document was deleted
    And I want the attachment to be removed from the list
