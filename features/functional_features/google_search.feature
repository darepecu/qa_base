@e2e_ready
Feature: Functional - 001 - Ask for a Loan
  Fields validation

  @regression
  Scenario Outline: A user starts a loan process
    Given "Test User" has navigated to Google Page
    When he searches for "<search_argument>"
    Then System should display "<page_title>" as result

    Examples:
      | search_argument | page_title                                  |
      | bcp             | Vía BCP                                     |
      | interbank       | Interbank: El tiempo vale más que el dinero |
      | continental     | BBVA Continental: Bienvenido a su banco     |

