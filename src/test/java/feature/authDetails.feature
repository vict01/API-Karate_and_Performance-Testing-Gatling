@ignore
Feature: API Authentication

  Background:
    * url 'https://reqres.in/api/register'

  Scenario: Authentication setup
    * def params =
      """
      {
         'email': '#(email)',
         'password': '#(password)'
      }
      """
    Given path ''
    And form fields params
    When method post
    And status 200
    And header Authorization = response.token
    Then print '\n\nThe token is:\n', response.token, '\n\n'
