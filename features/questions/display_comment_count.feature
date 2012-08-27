Feature: Display comment count on questions overview
  In order to get an overview wether a questions has been commented
  As a user
  I want to see the comment count in the question overview

  Background:
    Given I am signed in as a user
    And there is a question

  Scenario: Comment count on overview
    Given the question has 3 comments
    And I am on the questions overview page
    Then I want to see that the question has 3 comments
