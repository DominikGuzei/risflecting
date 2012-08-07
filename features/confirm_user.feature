Feature: Confirm User
  In order to create my user account
  As a visitor
  I want to confirm the invite email and create my profile

  Background: Visitor on confirmation page
    Given I am signed out
    And I have an invitation email
    And I open my invitation email
    And I click the first link in the email

  Scenario: Fill in all fields
    When I fill in my profile details
    And I confirm my profile
    Then I should be able to access the internal website

  Scenario: Leave all fields empty
    When I leave all fields empty
    And I confirm my profile
    Then I want to see 4 errors

  Scenario: Enter different passwords
    When I enter two different passwords
    And I confirm my profile
    Then I want to see 1 error

  Scenario: Access confirmation link a second time after confirmation as signed in user
    Given I fill in my profile details
    And I confirm my profile
    And I click the first link in the email
    Then I should be redirected to the internal website

  Scenario: Access confirmation link a second time after confirmation as signed out user
    Given I fill in my profile details
    And I confirm my profile
    And I am signed out
    And I click the first link in the email
    And I fill in my email address
    And I confirm my profile
    Then I want to see 1 error
