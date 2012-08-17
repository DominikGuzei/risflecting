Feature: Display comments for questions
  In order to see the feedback of other members
  As a user
  I want to view their comments next to my question

  Background:
    Given I am signed in as a user
    And there is a question
    And the question has 3 comments

  Scenario: Read all comments
    Given I am on the question details page
    Then I want to see 3 comments listed

  Scenario: Add a comment
    Given I am on the question details page
    When I add a comment
    Then I want to see 4 comments listed
    And I want to see my comment in the list

