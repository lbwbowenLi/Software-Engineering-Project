Feature: Add new login methods
    In order to provide easier login routine and support wide users' range
    As a admin, I would like to have more users
    I want to add a thirdparty login function

Scenario: Facebook Login
    Given I am on the "login page"
    When I choose the "Facebook" authentation link
    Then I should be able to login with my Facebook credentials username"csce606test1@gmail.com" pw"test123123123"
    And I should be able to see my "profile"
Scenario: Google Login
    Given I am on the "login page"
    When I choose the "Google" authentation link
    Then I should be able to login with my Facebook credentials username"csce606test1@gmail.com" pw"test123123123"
    And I should be able to see my "profile"