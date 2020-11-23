Feature: User Authentication

  Background:
    * def callAuth = call read('authDetails.feature'){email: 'eve.holt@reqres.in', password: 'pistol'}
    * def token = callAuth.token
    * url 'https://reqres.in/api/register'

    @Auth_Scenario
  Scenario: Authentication test
    Given path ''
    And header authorization = token
    When method get
    Then status 200
    And print '\n\nThe response is:\n', response.data[0], '\n\n'
