Feature: Create User
  In order to give people access to the internal website
  As an admin
  I want to create a new user

  Background: Signed in user
    Given I am sign in as a user

  Scenario: Fill all fields in
    Given I visit the form to create a new user
    And I fill in a correct email address
    And I invite the user
    Then I want to see feedback that the user was invited
    And the user should have received an email with instructions
    And I want to see the form to create a new user again

  Scenario: Leave all fields empty
    Given I visit the form to create a new user
    And I invite the user
    Then I want to see an error

  Scenario: Fill in an email which is already in use
    Given I visit the form to create a new user
    And I fill an already invited email address
    And I invite the user
    Then I want to see an error
