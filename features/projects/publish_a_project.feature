Feature: Publish a project
  In order to share my project experiences
  As a user
  I want to publish them as projects

  Background: Signed in user
    Given I am signed in as a user

  Scenario: Navigate to the creation form
    Given I am on the projects overview page
    When I click on 'Eintrag verfassen'
    Then I want to see the form to create a new project

  Scenario: Fill all fields in
    Given I visit the form to create a new project
    When I fill in all fields of the project form
    And I save the project
    Then I want to get feedback that the project was created successfully
    And I want to see the newly created project

  Scenario: Leave all fields empty
    Given I visit the form to create a new project
    When I leave all fields empty
    And I save the project
    Then I want to see 2 errors
