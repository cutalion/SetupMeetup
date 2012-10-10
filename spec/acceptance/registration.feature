Feature: Registration
  In order to use the app's secure features,
  I want to sign up

  @wip
  Scenario: Sign up with Google account
    Given I have a Google account
     When I click "Sign in with email" button
     Then I should be logged in with my google email
