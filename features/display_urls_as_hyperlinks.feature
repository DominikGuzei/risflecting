Feature: Display urls as hyperlinks
  In order to reach websites mentioned by other members
  As a user
  I want URLs to be real hyperlinks in posted content

  @javascript
  Scenario: Parse urls to hyperlinks in appointment description
    Given I am signed in as an admin
    And I visit the form to create a new appointment
    When I fill in all fields of the appointment form
    And I fill in a URL in the description field
    And I save the appointment
    Then I want the entered URL in the appointment description to be clickable

  Scenario: Parse urls to hyperlinks in comments
    Given I am signed in as a user
    And there is a question
    And I am on the question details page
    When I enter a URL in the comment field
    And I save the comment
    Then I want the URL in the saved comment to be clickable

  Scenario: Parse urls to hyperlinks in question description
    Given I am signed in as a user
    And I visit the form to create a new question
    When I fill in all fields of the question form
    And I enter a URL in the description field
    And I save the question
    Then I want the entered URL in the question details to be clickable
