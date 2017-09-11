class Scenario_Session

  attr_accessor :start_date_time

  def user
    @user ? @user : nil
  end

  def user=(user_name)
    @user = Data_Access::get_user(user_name)
  end

  def set_user_data(data)
    @user = data
  end

  def response
    @response ? @response : nil
  end

  def response=(response)
    @response = response
  end

  def base_path
    @base_path ? @base_path : nil
  end

  def base_path=(base_path)
    @base_path = base_path
  end

  def dash_account_number(account)

    if account.key?(:dashed_number)
      account[:dashed_number]
    else
      account[:dashed_number] = account[:number].to_s.insert(3, '-').insert(account[:number].size - 3, '-').insert(account[:number].size - 2, '-')
    end

  end

end
