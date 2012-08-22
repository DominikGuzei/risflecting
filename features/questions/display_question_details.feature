Feature: Question details
  In order to understand a question
  As a user
  I want to get further information and a description

  Background:
    Given I am signed in as a user
    And there is a question

  Scenario: View question
    Given I am on the questions overview page
    When I click on the title of the question
    Then I want to see the details of the question
