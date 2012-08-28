Feature: Divide users into groups
  In order to reduce my administration workload
  As an admin
  I want to divide users into specific groups

  Background:
    Given I am signed in as an admin
    And I visit the form to invite a new user
    And I fill in a correct email address

  Scenario: Put invited user to the 'Pool' group
    When I select the 'Pool' group for the user
    And I invite the user
    Then the user should belong to the 'Pool' group

  Scenario: Put invited user to the 'Steuergruppe' group
    When I select the 'Steuergruppe' group for the user
    And I invite the user
    Then the user should belong to the 'Steuergruppe' group

  Scenario: Put invited user to the 'Administratoren' group
    When I select the 'Administratoren' group for the user
    And I invite the user
    Then the user should belong to the 'Administratoren' group
