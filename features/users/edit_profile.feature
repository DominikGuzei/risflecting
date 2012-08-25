Feature: Edit profile
  In order to adjust information about me
  As a user
  I want to edit my profile

  Background:
    Given I am signed in as a user

  Scenario: Navigate to edit form
    Given I am on my profile page
    When I click on 'Profil bearbeiten'
    Then I want to see the form to edit my profile information

  Scenario: Change my profile information
    Given I am on the page with the profile edit form
    When I change my name, email and phone
    And I save the changes
    Then I want to see the changes on my profile page

  Scenario: Keep existing profile information
    Given I am on the page with the profile edit form
    When I change none of my informations
    And I save the informations anyway
    Then I want to see the existing informations on my profile page

  Scenario: Remove my profile information
    Given I am on the page with the profile edit form
    When I remove my name, email and phone
    And I save the changes
    Then I want to see 4 errors
