Feature: Function handling test

  Background:
    * def javaMethod = Java.type('helper.Methods')
    * def method = new javaMethod()
    * url 'https://petstore3.swagger.io/api/v3/pet/'
    * def myFunction =
    """
    function(second){
       for(i=0; i<=second; i++){
        java.lang.Thread.sleep(1*1000);
       }
    }
    """

  @Scenario7
  Scenario: Call @Scenario4 from CRUD_Testing.feature file and validate status field
    * def scenarioDesc = 'Call @Scenario4 from CRUD_Testing.feature file'
    * def printScenario = method.printScenario(scenarioDesc)
    * def responseTitle = method.getResponseTitle(scenarioDesc)
    Given print printScenario
    When def CRUD_scenario = call read('CRUD_Testing.feature@Scenario4')
    Then match CRUD_scenario.response.status != null
    * call myFunction 1
