Given(/^User asks if System is in work time$/) do
  send_status_request
end

Then(/^System responds it is in work time$/) do
  get_closed_status(@scenario_session.response).should == false
end