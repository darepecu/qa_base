Given(/^"([^"]*)" has navigated to (?:the | )Loans Web App$/) do |customer|
  visit(Home_Page)
  on(Home_Page).loaded?.should be true
  merge_customer_information(customer)
end

When(/^(?:she|he) fills "([^"]*)" as DNI and a valid amount$/) do |dni|
  on(Home_Page).enter_values( @scenario_session.user[:amount], @scenario_session.user[:paydate])
end

Then(/^System responds an error message: "([^"]*)"$/) do |message|
  on(Home_Page).loaded?.should be true
  actual = on(Home_Page).get_error
  expected = message
  actual.should ==expected
end

When(/^(?:she|he) asks for a S\/(.*) loan$/) do |amount|
  on(Home_Page).enter_values(amount, @scenario_session.user[:paydate])
end

When(/^(?:she|he) asks for a loan$/) do
  on(Home_Page).enter_values(@scenario_session.user[:amount], @scenario_session.user[:paydate])
end

When(/^(?:she|he) asks for a loan with paydate "([^"]*)"$/) do |paydate|
  on(Home_Page).enter_values(@scenario_session.user[:amount], paydate)
end

When(/^(?:she|he) asks for a loan without specifying a pay date$/) do
  on(Home_Page).enter_values(@scenario_session.user[:amount], '')
end

When(/^(?:she|he) fills "([^"]*)" as DNI$/) do |dni|
  on(Home_Page).enter_dni(dni)
end

Then(/^System shows truncated DNI: "([^"]*)"$/) do |shown_dni|
  on(Home_Page).get_dni.should == shown_dni
end

Then(/^System shows Welcome Page$/) do
  on(Home_Page).loaded?.should be true
end

Then(/^DNI field remains empty$/) do
  on(Home_Page).get_dni.should == ''
end

And(/^System blocks Submit button$/) do
  on(Home_Page).continue_element.disabled?.should be true
end

Then(/^amount field remains empty$/) do
  on(Home_Page).get_amount.should == ''
end

When(/^(?:she|he) fills S\/(.*) as amount$/) do |amount|
  on(Home_Page).enter_amount(amount)
  #on(Home_Page).focus_dni
end

Then(/^System shows truncated amount: "([^"]*)"$/) do |shown_amount|
  on(Home_Page).get_amount.should == shown_amount
end


When(/^she starts a loan process for:$/) do |table|
  amount = table.hashes.first['Loan Amount']
  pay_date = table.hashes.first['Preferred Pay Date']
  on(Home_Page).enter_amount(amount)
  on(Home_Page).select_paydate(pay_date)
  on(Home_Page).submit
end

Then(/^she should be able to identify herself as a BCP client$/) do
  pending
end