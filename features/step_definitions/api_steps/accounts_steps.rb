Given(/^System is ready to send Accounts request for "([^"]*)"$/) do |customer|
  merge_customer_information(customer)  #SET
  step "System is ready to send Customer request for \"#{customer}\""
  #step "System requests for her Customer Information"
  #@scenario_session.idc = get_idc(@scenario_session.response)
end

Then(/^Accounts with Balance Service correctly responds accounts data$/) do
  get_status_code(@scenario_session.response).should == 200
end

Then(/^Accounts with Balance Service responds without any PDH account$/) do
  get_status_code(@scenario_session.response).should == 200
  accounts = get_accounts(@scenario_session.response)
  accounts_should_not_include_pdh(accounts)
end

When(/^System sends her DNI to Accounts with Balance service$/) do
  token = @scenario_session.token
  dni = @scenario_session.user[:dni].to_s
  send_accounts_request(dni,token)
end

When(/^System sends DNI "([^"]*)" to Accounts with Balance service$/) do |dni|
  token = @scenario_session.token
  send_accounts_request(dni,token)
end

When(/^System sends "([^"]*)"'s DNI to Accounts with Balance service$/) do |customer|
  token = @scenario_session.token
  merge_customer_information(customer)  #SET
  dni = @scenario_session.user[:dni].to_s
  send_accounts_request(dni,token)
end

Then(/^Accounts with Balance Service responds with PDH accounts$/) do
  get_status_code(@scenario_session.response).should == 200
  accounts = get_accounts(@scenario_session.response)
  accounts_should_include_pdh(accounts)
end

Then(/^Accounts with Balance Service responds with only PDH accounts$/) do
  get_status_code(@scenario_session.response).should == 200
  accounts = get_accounts(@scenario_session.response)
  accounts_should_include_only_pdh(accounts)
end

Then(/^Accounts with Balance Service responds with only one PDH account$/) do
  get_status_code(@scenario_session.response).should == 200
  accounts = get_accounts(@scenario_session.response)
  accounts_should_include_only_one_pdh(accounts)
end

Then(/^System responds with error name "([^"]*)"$/) do |expected_message|
  get_status_code(@scenario_session.response).should == 403
  received_message = get_api_error_name(@scenario_session.response)
  received_message.should == expected_message
end

Then(/^System responds with error message "([^"]*)"$/) do |expected_message|
  get_status_code(@scenario_session.response).should == 403
  received_message = get_api_error_message(@scenario_session.response)
  received_message.should == expected_message
end

Then(/^System responds with sanity error message "([^"]*)"$/) do |expected_message|
  get_status_code(@scenario_session.response).should == 400
  received_message = get_api_sanity_error_message(@scenario_session.response)
  received_message.should == expected_message
end

And(/^System responds first account is type "([^"]*)"$/) do |type|
  get_first_account_type(@scenario_session.response).should == type
end

And(/^System responds at least an account is type "([^"]*)"$/) do |type|
  accounts = get_accounts(@scenario_session.response)
  is_any_account_type(accounts,type).should be true
end

Then(/^Accounts with Balance Service responds with no accounts$/) do
  accounts = get_accounts(@scenario_session.response)
  accounts.length.should == 0
end

Then(/^Accounts with Balance Service responds with only one account$/) do
  get_status_code(@scenario_session.response).should == 200
  accounts = get_accounts(@scenario_session.response)
  accounts.size.should == 1
end