Feature: Upload profile avatar
  In order to make me more recognizable
  As a user
  I want to upload a profile picture

  Background:
    Given I am signed in as a user

  Scenario: Access profile edit form
    Given I am on my profile page
    When I click on 'Profil bearbeiten'
    Then I want to see the form to edit my profile information

  Scenario: Upload profile avatar
    Given I am on the page with the profile edit form
    When I choose a new avatar image
    And I save the changes
    Then I want to see the newly uploaded avatar on my profile page
