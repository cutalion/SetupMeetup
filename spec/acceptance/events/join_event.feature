Feature: Join the event
  As a registered user
  I want to join any event
  To receive updates about it

  Scenario: Join the event
    Given I'm a signed in user
    And I'm on the event page
    When I join the event
    Then I should be in the participants list
