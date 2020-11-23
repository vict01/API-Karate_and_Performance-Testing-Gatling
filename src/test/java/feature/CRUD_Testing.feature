Feature: Test of PetStore API

  Background:
    * def javaMethod = Java.type('helper.Methods')
    * def method = new javaMethod()
    * def jsonData = read('helper/petBody.json')
    * def responseRecordDeleted = method.getResponseRecordDeleted()
    * def responseStatusAvailable = {status: 'available'}
    * def responseStatusNotNull = {status: '#notnull'}
    * header content-type = 'application/json'
    * url 'https://petstore3.swagger.io/api/v3/pet/'

  @Scenario1
    @parallel=false
  Scenario Outline: Scenario: <scenario>
    * def printScenario = method.printScenario("<scenario>")
    * def responseTitle = method.getResponseTitle("<scenario>")
    Given print printScenario
    When path <expression>
    And request <body>
    And param additionalMetadata = "query"
    And method <method>
    And status <status>
    And print responseTitle, response
    Then match response contains <response>

    Examples:
      | scenario                      | expression | body        | method | status | response                |
      | 01) Delete the pet with id 26 | 26         | {}          | delete | 200    | responseRecordDeleted   |
      | 02) Add pet with id 27        | ''         | jsonData[0] | post   | 200    | responseStatusAvailable |
      | 03) Add pet with id 10        | ''         | jsonData[4] | post   | 200    | responseStatusAvailable |

  @Scenario2
  Scenario: Inquire the pet with id 27
    * def scenarioDesc = 'Inquire the pet with id 27'
    * def printScenario = method.printScenario(scenarioDesc)
    * def responseTitle = method.getResponseTitle(scenarioDesc)
    Given print printScenario
    When path '27'
    And  method get
    And  status 200
    And  print responseTitle, response
    Then match response == jsonData[0]

  @Scenario3
  Scenario: Add new pet with id 26
    * def scenarioDesc = 'Add new pet with id 26'
    * def printScenario = method.printScenario(scenarioDesc)
    * def responseTitle = method.getResponseTitle(scenarioDesc)
    Given print printScenario
    When path ''
    And  request jsonData[2]
    And  method post
    And  status 200
    And  print responseTitle, response
    Then match response contains responseStatusNotNull

  @Scenario4
  @ignore
  Scenario: Update name, category and status to the pet with id 10
    * def scenarioDesc = 'Update name, category and status to the pet with id 10'
    * def printScenario = method.printScenario(scenarioDesc)
    * def responseTitle = method.getResponseTitle(scenarioDesc)
    Given print printScenario
    When path ''
    And request jsonData[3]
    And  method put
    And  status 200
    And  print responseTitle, response
    Then match response contains responseStatusAvailable
