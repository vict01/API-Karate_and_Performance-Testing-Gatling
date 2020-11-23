Feature: Miscellaneous tests

  Background:
    * def javaMethod = Java.type('helper.Methods')
    * def method = new javaMethod()
    * url 'https://petstore3.swagger.io/api/v3/pet/'

  @Scenario5
  Scenario Outline: Inquire pet by id <identifier>
    * def scenarioDesc = 'Inquire pet by id <identifier>'
    * def printScenario = method.printScenario(scenarioDesc)
    * def responseTitle = method.getResponseTitle(scenarioDesc)
    Given print printScenario
    When path <identifier>
    And  method get
    And  status 200
    And  print responseTitle, response
    Then match response contains {id: <identifier>}

    Examples:
      | identifier |
      | 10         |
      | 33         |

  @Scenario6
  Scenario: Inquire the pet with id 27 (Using global variable from karate-config.js)
    * def scenarioDesc = 'Inquire the pet with id 27'
    * def printScenario = method.printScenario(scenarioDesc)
    * def responseTitle = method.getResponseTitle(scenarioDesc)
    Given print printScenario
    When path '27'
    And  method get
    And  status 200
    And  print '\n\nBase config: ', baseConfig
    And  print responseTitle, response
    And  match response.id == 27
