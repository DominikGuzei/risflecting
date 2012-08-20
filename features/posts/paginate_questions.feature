Feature: Paginate questions
  In order to optimize browsing questions
  As a user
  I just want to see 15 question at once

  Background:
    Given I am signed in as a user

  Scenario: List all questions
    Given there are 20 questions
    And I am on the questions and messages page
    And I navigate to the next questions page
    Then I want to see a list containing 5 items
