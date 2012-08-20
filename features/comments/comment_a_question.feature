Feature: Comment a question
  In order to help other members
  As a user
  I want to write a comment to a specific question

  Background:
    Given I am signed in as a user
    And there is a question

  Scenario: Submit comment through form on details page
    Given I am on the question details page
    When I fill in the comment form
    And I save the comment
    Then I want to get feedback that the comment was created successfully

  Scenario: Submit empty form
    Given I am on the question details page
    When I leave all fields empty
    And I save the comment
    Then I want to see 1 error
