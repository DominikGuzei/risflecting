Feature: Put users into groups
  In order to reduce my administration workload
  As an admin
  I want to put users into specific groups

  Background:
    Given I am signed in as an admin
    And I visit the form to invite a new user
    And I fill in a correct email address

  Scenario: Put invited user into the 'Pool' group
    When I select the 'Pool' group for the user
    And I invite the user
    Then the user should belong to the 'Pool' group

  Scenario: Put invited user into the 'Steuergruppe' group
    When I select the 'Steuergruppe' group for the user
    And I invite the user
    Then the user should belong to the 'Steuergruppe' group

  Scenario: Put invited user into the 'Administratoren' group
    When I select the 'Administratoren' group for the user
    And I invite the user
    Then the user should belong to the 'Administratoren' group
