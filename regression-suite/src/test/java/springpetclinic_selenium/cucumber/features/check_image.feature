@smoke
Feature: Check Images
  Looking for online banking image

  Scenario: Online banking image is displayed
    Given I am on the landing page
    Then The "online banking" image is "onlinebanking.jpeg"
