Feature: Signup and Signin
  As a User
  I should be able to sign up and sign in
  So that I can use the product securely

  Scenario: User Signs up
    When I sign up
    Then I should have a pulse
    And I should be on the edit page

  Scenario: User Signs in
    Given I have an account
    When I sign in
    Then I should be on the edit page

  Scenario: Visitor Tries to Hack
    Given I'm a visitor
    Then I should not be able to edit a page

  Scenario: Visitor Views Pulse
    Given I'm a visitor
    Then I should be able to view a pulse