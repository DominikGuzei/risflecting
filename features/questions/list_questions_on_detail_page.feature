Feature: List questions on details page
  In order to switch between questions rapidly
  As a user
  I want to see a other questions on every details page

  Background:
    Given I am signed in as a user
    And there are 6 questions

  Scenario:
    Given I am on the questions overview page
    And I click on the first question
    Then I want to see a list containing 5 recent alternative questions
