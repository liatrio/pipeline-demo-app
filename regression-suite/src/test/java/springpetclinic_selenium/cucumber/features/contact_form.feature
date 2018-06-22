@dynamic
Feature: Contact form
  Testing the contact form

  Scenario: Filling out no fields
    Given I am on a page with the contact form
    Then I should see a form with ID "contact"

  Scenario: Filling out one field
    Given I am on a page with the contact form
    When I fill in "name" with "test"
    When I press "submit"
    Then I should not see thank you message

  Scenario: Filling out two fields
    Given I am on a page with the contact form
    When I fill in "name" with "test"
    When I fill in "email" with "test@test.com"
    When I press "submit"
    Then I should not see thank you message

  Scenario: Filling out all fields
    Given I am on a page with the contact form
    When I fill in "name" with "test"
    When I fill in "email" with "test@test.com"
    When I fill in "message" with "test"
    When I press "Send Message"
    Then I should see thank you message
