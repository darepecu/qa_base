module Common_Api

  def get_response(path, token_key=nil, token_value=nil)
    sleep 1
    if token_key == 'bearer'
      response = RestClient.get(path,
                                {
                                    "Content-Type" => "application/json",
                                    "Authorization" => "bearer "+token_value
                                }
      ){|response, request, result| response }

    else
      response = RestClient.get(path,
                                {
                                    "Content-Type" => "application/json"
                                }
      ){|response, request, result| response }
    end

      puts "Request (GET): " + path
      puts "Response: " + response.to_s.force_encoding("UTF-8")
      puts "Response Headers: " + response.headers.to_s
      puts "Response Code: "+ response.code.to_s

    return response
  end

  def get_response_by_post(path,json,token_key=nil,token=nil,captcha=nil)
    sleep 1
    if token_key == 'bearer'
      response = RestClient.post(path,json,
                                {
                                    "Content-Type" => "application/json",
                                    "Authorization" => "bearer "+token
                                }
      ){|response, request, result| response }

    elsif captcha != nil && token_key != nil
      response = RestClient.post(path,json,
                               {
                                   "Content-Type" => "application/json",
                                   token_key => token,
                                   "X-TOKEN-CAPTCHA" => captcha
                               }
      ){|response, request, result| response }
      puts "Captcha: " + "X-TOKEN-CAPTCHA: " + captcha

    elsif token_key == nil
      response = RestClient.post(path,json,
                                 {
                                     "Content-Type" => "application/json"
                                 }
      ){|response, request, result| response }
    else
      response = RestClient.post(path,json,
                                {
                                    "Content-Type" => "application/json",
                                    token_key => token
                                }
      ){|response, request, result| response }
    end
    puts "Request (POST): URL: " + path
    puts " Body: " + json
    unless token_key == nil
      if token_key == 'bearer'
        puts "Header: " +
        '{
            "Content-Type" : "application/json",
              "Authorization" : "'+token_key+' '+token+'"
        }'
      else
        puts "Header: " +
                 '{
            "Content-Type" : "application/json",
              "'+token_key+'": "'+token+'"
        }'
      end

    end
    puts "Response: " + response.to_s
    puts "Response Headers: " + response.headers.to_s
    puts "Response Code: "+ response.code.to_s
    return response
  end

  def get_response_by_delete(path,token_key,token)
    sleep 1
    if token_key == 'bearer'
      response = RestClient.delete(path,
                                 {
                                     "Content-Type" => "application/json",
                                     "Authorization" => "bearer "+token
                                 }
      ){|response, request, result| response }

    else
      response = RestClient.delete(path,
                                 {
                                     "Content-Type" => "application/json",
                                     token_key => token
                                 }
      ){|response, request, result| response }
    end
    puts "Request (DELETE): URL: " + path
    puts "Header: " +
             '{
        "Content-Type" : "application/json",
          "Authorization" : "'+token_key+' '+token+'"
    }'
    puts "Response: " + response.to_s
    puts "Response Headers: " + response.headers.to_s
    puts "Response Code: "+ response.code.to_s
    return response
  end

  def hash_json(json)
    json=Data_Access.symbolize!(json)
  end

  def get_status_code(response)
    return response.code
  end

  def get_response_body(response)
    JSON.parse(response.body)
  end

  def get_success_result(response)
    @data = get_response_body(response)
    return @data["success"]
  end

end
World(Common_Api)