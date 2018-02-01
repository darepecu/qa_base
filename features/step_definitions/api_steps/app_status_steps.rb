Given(/^User asks if System is in work time$/) do
  #ejemplo de creación de una entidad directamente
  #Student.create(first_name: "Sven", last_name: "sven@theodinproject.com", second_last_name: "asd", code: "d105001", sex: "", address: "", document_id: "1577625", grade: "")
  send_status_request
end

Then(/^System responds it is in work time$/) do
  get_closed_status(@scenario_session.response).should == false
end