Given(/^"([^"]*)" has navigated to Google Page$/) do |customer|
  visit(Google_Page)
  on(Google_Page).loaded?.should be true
  @scenario_session.user=customer
end

When(/^he searches for "([^"]*)"$/) do |query|
  on(Google_Page).enter_query(query)
  on(Google_Page).submit
end

Then(/^System should display "([^"]*)" as result$/) do |title|
  on(Google_Page_Results).loaded?.should be true
  on(Google_Page_Results).page_should_contains(title)
end