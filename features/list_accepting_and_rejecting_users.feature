Feature: List accepting and rejecting users
  In order to see which users already responded to an appointment
  As an user
  I want to see a list of all users who accepted or rejected the appointment

  Background:
    Given I am signed in as a user

  Scenario: Display list of accepting and rejecting users
    Given there is an appointment
    And 3 users accepted the appointment
    And 2 users rejected the appointment
    And I am on the appointments detail page
    Then I want to see a list containing 3 users who accepted
    And I want to see a list containing 2 users who rejected
