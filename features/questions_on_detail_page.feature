Feature: Questions on details page
  In order to switch between questions rapidly
  As a user
  I want to see a other questions on every details page

  Background:
    Given I am signed in as a user
    And there are 6 questions
    And I am on the posts overview page

  Scenario:
    When I click on the first question
    Then I want to see a list containing 5 recent alternative questions
