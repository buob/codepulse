Feature: Have a Pulse
  As a User
  I should be able to have a Pulse
  To show off my private and public dev activity

  Background:
    Given a user with a pulse exists

  Scenario: Seeing pulse info
    When I'm viewing that pulse
    Then I should see the pulse info

  Scenario: Seeing social media
    Given the pulse has social profiles connected
    When I'm viewing that pulse
    Then I should see the social profiles

  Scenario: Seeing my repos
    Given they have some github repos
    When I'm viewing that pulse
    Then I should see the repos listed
    And they should have commit activity
