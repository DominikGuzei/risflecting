Feature: Appoinments list
  In order to get an overview of all appointments
  As a user
  I want to view all appointments, separated into past and future ones

  Background:
    Given I am signed in as a user

  Scenario: View appointments
    Given there are 5 appointments in the future
    And I am on the Dashboard
    When I navigate to 'Termine' through the main navigation
    Then I want to see all appointments listed

  Scenario: Display appointments separated past and future ones
    Given there is an appointment in the past
    And there are 2 appointments in the future
    And I am on the appointments overview page
    Then I want to see a list containing 2 future appointments
    And I want to see a list containing 1 past appointment
    And I want the past appointment not to be acceptable or rejectable
