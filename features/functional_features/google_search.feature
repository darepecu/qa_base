@e2e_ready
Feature: Functional - 001 - Ask for a Loan
  Fields validation

  @regression
  Scenario Outline: A user starts a loan process
    Given "Test User" has navigated to Google Page
    When he searches for "<search_argument>"
    Then System should display "<page_title>" as result

    Examples:
      | search_argument | page_title  |
      | 500    | 02 de cada mes     |
      | 40000  | 15 de cada mes     |
      | 250000 | 28 de cada mes     |

