Feature: Post a question
  In order to get feedback from other members
  As a user
  I want to post a question

  Background: Signed in user
    Given I am signed in as a user

  Scenario: Navigate to the creation form
    Given I am on the questions overview page
    When I click on 'Frage oder Mitteilung verfassen'
    Then I want to see the form to create a new question

  Scenario: Fill all fields in
    Given I visit the form to create a new question
    When I fill in all fields of the question form
    And I save the question
    Then I want some feedback that the question was created successfully
    And I want to see the newly created question

  Scenario: Leave all fields empty
    Given I visit the form to create a new question
    When I leave all fields empty
    And I save the question
    Then I want to see 2 errors
