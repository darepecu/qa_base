module AppStatus_Api

  def send_status_request
    @scenario_session.response = get_response(@scenario_session.base_path+"loan/status")
  end

  def get_closed_status(response)
    @data = get_response_body(response)
    return @data["response"]["closed"]
  end

end
World(AppStatus_Api)