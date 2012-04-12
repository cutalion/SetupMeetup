Feature: Registration
  In order to use the app's secure features,
  I want to sign up

  Scenario: Sign up with email only
    Given I'm guest on the site
    When I fill out email field only
    Then I should be registered
    And I should be logged in

  Scenario: Sign up with Facebook account
    Given I have a Facebook account
    When I click "Sign in with Facebook" button
    Then I should be logged in with my facebook email

  Scenario: Sign up with Twitter account
    Given I have a Twitter account
    When I click "Sign in with Twitter" button
    Then I should be logged in without email

  Scenario: Sign up with Google account
    Given I have a Google account
    When I click "Sign in with Google" button
    Then I should be logged in with my google email
