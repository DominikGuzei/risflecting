Feature: Edit question
  In order to correct type errors
  As a user
  I want to edit my question

  Background:
    Given I am signed in as a user

  Scenario: Question from a different user
    Given there is one question from a different user
    And I am on the question details page
    Then I do not want to see a 'Bearbeiten' link

  Scenario: Access form through question details page
    Given there is one question from myself
    And I am on the question details page
    When I click on 'Bearbeiten'
    Then I want to see the form to edit the question

  Scenario: Change question information
    Given there is one question from myself
    And I am on the question edit page
    When I change the question´s title and description
    And I save the changes
    Then I want to see the changes on the question details page

  Scenario: Keep existing question information
    Given there is one question from myself
    And I am on the question edit page
    When I change none of the question information
    And I save the question anyway
    Then I want to see the existing question information on the question details page

  Scenario: Remove question information
    Given there is one question from myself
    And I am on the question edit page
    When I remove the question´s title and description
    And I save the changes
    Then I want to see 2 errors
