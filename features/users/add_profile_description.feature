Feature: Add profile description
  In order to present my self to other members
  As a user
  I want to provide additional information about me

  Background:
    Given I am signed in as a user

  Scenario: Add a description about me
    Given I am on the page with the profile edit form
    When I add a description with some informations about me
    And I save the changes
    Then I want to see feedback that the changes were successfully saved
    And I want to see the description on my profile page
