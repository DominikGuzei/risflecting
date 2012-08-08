Feature: Invite User
  In order to give people access to the internal website
  As an admin
  I want to invite a new user

  Background: Signed in user
    Given I am sign in as a user
    And I visit the form to invite a new user

  Scenario: Fill all fields in
    When I fill in a correct email address
    And I invite the user
    Then I want to see feedback that the user was invited
    And the user should have received an email with instructions
    And I want to see the form to invite a new user again

  Scenario: Leave all fields empty
    When I leave all fields empty
    And I invite the user
    Then I want to see feedback that I have to enter an email

  Scenario: Fill in an email which is already in use
    When I fill an already invited email address
    And I invite the user
    Then I want to see feedback that the user is already invited
