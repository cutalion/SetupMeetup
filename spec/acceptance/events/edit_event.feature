Feature: Edit event
  As an event owner
  I want to edit my event

  Scenario: Edit event as an owner
    Given I'm a signed in user
    And I'm an owner of the event
    And I'm on the event page
    When I click "Edit" button
    And I change the event
    And I should see updated event
