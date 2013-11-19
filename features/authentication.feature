Feature: Signup and Signin
  As a User
  I should be able to sign up and sign in
  So that I can use the product securely

  Scenario: User Signs up
    When I sign up
    Then I should be able to edit my new pulse

  Scenario: Visitor Tries to Hack
    Given I'm a visitor
    And a user with a pulse exists
    Then I should not be able to edit the pulse

  Scenario: Visitor Views Pulse
    Given I'm a visitor
    And a user with a pulse exists
    Then I should be able to view the pulse
