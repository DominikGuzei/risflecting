Feature: Delete question attachments
  In order to get rid of out-dated attachments
  As a user
  I want to delete attachments from my question

  Background:
    Given I am signed in as a user

  Scenario: Question from myself
    Given there is one question from myself
    And the question has 1 attached file
    And I am on the question details page
    Then I want to see a trash bin next to the attachment

  Scenario: Question from different user
    Given there is one question from a different user
    And the question has 1 attached file
    And I am on the question details page
    Then I do not want to see a trash bin next to the attachment

  @javascript
  Scenario: Delete attachment from a question from myself
    Given there is one question from myself
    And the question has 1 attached file
    And I am on the question details page
    When I click the trash bin next to the attachment
    And I confirm the upcoming dialog
    Then I want to get feedback that the document was deleted
    And I want the attachment to be removed from the list
