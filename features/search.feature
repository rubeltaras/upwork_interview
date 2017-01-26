Feature: Search engine
  In order to avoid silly mistakes
  In upwork search engine
  I want to check simplest search scenario

  Scenario: Search jobs with filters
    Given I am on 'landing' page
    When I fill and submit search field with query 'Java'
    And search profiles with the following criteria:
      | category | Web, Mobile & Software Dev |
      | rate     | $60/hr and above           |
    Then I should see that first '5' results have skill 'Java'
    Then I should see that first '5' results have rate '60+'
