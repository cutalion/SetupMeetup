Feature: Logout
  In order to end work with application and hide my private data from other users of computer
  I want to log out

  Scenario: Log out
    Given I'm a signed in user
    When I click logout
    Then I should be logged out
