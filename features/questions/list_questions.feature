Feature: List questions
  In order to gain an overview over current questions
  As a user
  I want to see all questions listed on one page

  Background:
    Given I am signed in as a user

  Scenario: List all questions
    Given there are 5 questions
    And I am on the questions and messages page
    Then I want to see a list containing 5 items

  Scenario: Display title and author of each question in the list
    Given there is a question
    And I am on the Dashboard
    When I navigate to 'Fragen & Mitteilungen' through the main navigation
    Then I want to see the title and author of the question
