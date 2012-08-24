Feature: Display profile
  In order to learn more about other members
  As a user
  I want to view their profiles

  Background:
    Given I am signed in as a user

  @javascript
  Scenario: Navigate to profile of my own
    Given I am on the Dashboard
    When I click on my name in the main navigation
    And I navigate to 'Mein Profil'
    Then I want to see my account details

  Scenario: Visit profile through question detail
    Given there is a question
    And I am on the question details page
    When I click on the name of the question´s author
    Then I want to see the author´s profile

  Scenario: Visit profile through question comments
    Given there is a question
    And the question has a comment
    And I am on the question details page
    When I click on the name of the comment´s author
    Then I want to see the author´s profile

  Scenario: Visit profile through questions overview
    Given there is a question
    And I am on the questions overview page
    When I click on the name of the question´s author
    Then I want to see the author´s profile

  Scenario: Visit profile through project detail
    Given there is a project
    And I am on the project details page
    When I click on the name of the project´s author
    Then I want to see the author´s profile

  Scenario: Visit profile through projects overview
    Given there is a project
    And I am on the projects overview page
    When I click on the name of the project´s author
    Then I want to see the author´s profile

  Scenario: Visit profile through appointment acceptance/rejection lists
    Given there is an appointment
    And 1 user already accepted that appointment
    And I am on the appointment details page
    When I click on the user´s name
    Then I want to see the user´s profile

