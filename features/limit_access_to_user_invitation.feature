Feature: Limit access to user invitation
  In order to have control over who is invited to the internal website
  As an admin
  I want to be the only one who can invite new users

  Scenario: As an user
    Given I am signed in as a user
    Then I do not want to see a link to invite a new user
