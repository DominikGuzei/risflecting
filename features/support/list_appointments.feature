Feature: Appoinments list
  In order to get an overview of all appointments
  As a user
  I want to view a list of all appointments

  Background:
    Given I am sign in as a user
    Given there are 5 appointments

  Scenario: View appointment
    Given I am on the Dashboard
    When I navigate to 'Termine' through the main navigation
    Then I want to see a list of all appointments
