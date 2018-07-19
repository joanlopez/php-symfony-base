@environment
Feature: Environment
  I want to check the environment is working

  Scenario: Get the welcome message
    When I request "hello" using HTTP "GET"
    Then the response code is "200"
    And the response body contains JSON:
    """
    {"message": "Hello World"}
    """