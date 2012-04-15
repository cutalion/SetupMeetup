Feature: Create new event
  As a rigistered user
  I want to create a page for new meetup

  Scenario: Create new event
    Given I'm registered user
    And I'm on the home page
    When click "Create event" button
    And fill out event form
    Then new event should be created
    And I should see new event
