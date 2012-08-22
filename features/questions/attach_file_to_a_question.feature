Feature: Attach a file to a question
  In order to provide additional resources to a question
  As a user
  I want to attach files

  Background:
    Given I am signed in as a user

  Scenario: Question from a different user
    Given there is one question from a different user
    And I am on the questions overview page
    When I click on the title of the question
    Then I do not want to see the attachment upload form

  Scenario: Question of my own
    Given there is one question from myself
    And I am on the questions overview page
    When I click on the title of the question
    Then I want to see the attachment upload form

  Scenario: Add an attachment
    Given there is one question from myself
    And I am on the questions overview page
    When I click on the title of the question
    When I add an attachment
    And I upload the attachment
    Then I want some feedback that the attachment was successfully uploaded
    And I want to be on the question details page
