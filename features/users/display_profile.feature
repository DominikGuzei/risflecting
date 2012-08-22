Feature: Display profile
  In order to learn more about other members
  As a user
  I want to view their profiles

  Background:
    Given I am signed in as a user

  @javascript
  Scenario: Navigate to profile
    Given I am on the Dashboard
    When I click on my name in the main navigation
    And I navigate to 'Mein Profil'
    Then I want to see my account details
