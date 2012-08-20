Feature: Confirm User
  In order to create my user account
  As a visitor
  I want to confirm the invite email and create my account

  Background: Visitor on confirmation page
    Given I am signed out
    And I have an invitation email
    And I open my invitation email
    And I click the confirmation link in the email

  Scenario: Fill in all fields
    When I fill in my account details
    And I confirm my account
    Then I want to be able to access the internal website

  Scenario: Leave all fields empty
    When I leave all fields empty
    And I confirm my account
    Then I want to see 4 errors

  Scenario: Enter different passwords
    When I enter two different passwords
    And I confirm my account
    Then I want to see 1 error

  Scenario: Clicking the confirmation link a second time as a confirmed user
    Given my account is confirmed
    And I click the first link in the email
    Then I want to be redirected to the internal website

  Scenario: Clicking the confirmation link a second time as a signed out and confirmed user
    Given my account is confirmed
    When I sign out
    And I click the first link in the email
    And I fill in my email address
    And I confirm my account
    Then I want to see 1 error
