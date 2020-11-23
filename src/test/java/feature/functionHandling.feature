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

  @Scenario8
  Scenario: Count the number of users in response
    Given url 'https://reqres.in/api/users?page=2'
    When method get
    Then status 200
    * def data = response.data
    And print '\n\nRetrieved data: \n', data
    * def myFun =
    """
    function(arg){
       return arg.length
    }
    """
    * def numberOfUsers = call myFun data
    Then print '\n\nThe number of users is:\n', numberOfUsers, '\n\n'

  @Scenario9
  Scenario: Get a specific user by id
    Given url 'https://reqres.in/api/users?page=2'
    When method get
    Then status 200
    * def data = response.data
    And print '\n\nRetrieved entire data: \n', data
    * def myFun =
    """
    function(arg){
       for(i=0; i<arg.length; i++){
          if(arg[i].id==userId){
            return arg[i];
          }
       }
    }
    """
    * def userId = 9
    * def result = call myFun data
    Then print '\n\nThe found user is:\n', result, '\n\n'

