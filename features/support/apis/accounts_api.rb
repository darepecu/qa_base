module Accounts_Api

  def send_accounts_request(dni,token)
    token_name = "bearer"
    @scenario_session.response = get_response(@scenario_session.base_path+"loan/accounts/balance/"+dni,token_name,token)
  end

  def get_account_balance(response,account_number)
    @data = get_response_body(response)
    accounts =  @data["response"]
    balance = nil

    for i in 0..((accounts.length)-1)
      if accounts[i]["acctNumber"] == account_number
        balance = accounts[i]["balance"]
        puts balance
        break
      end
    end

    return balance
  end

  def get_accounts(response)
    @data = get_response_body(response)
    @data["response"]
  end

  def get_first_account_type(response)
    @data = get_response_body(response)
    @data["response"][0]["acctType"]
  end

  def is_any_account_type(accounts,type)
    type_exists = false
    for i in 0..((accounts.length)-1)
      #accounts[i]["ctaCls1Cod"].should == "PAG.HABERS"
      if accounts[i]["acctType"] == type
        type_exists = true
      end
    end
    return type_exists
  end

  def count_payment_false_values(accounts)
    count = 0
    for i in 0..((accounts.length)-1)
      #accounts[i]["ctaCls1Cod"].should == "PAG.HABERS"
      if accounts[i]["payment"] == false
        count = count + 1
      end
    end
    count
  end

  def count_payment_true_values(accounts)
    count = 0
    for i in 0..((accounts.length)-1)
      #accounts[i]["ctaCls1Cod"].should == "PAG.HABERS"
      if accounts[i]["payment"] == true
        count = count + 1
      end
    end
    count
  end

  def accounts_should_not_include_pdh(accounts)
    count = count_payment_false_values(accounts)

    if count != 0
      fail("Las cuentas resultantes incluyen al menos 1 cuenta PDH (Al menos un valor Payment está seteado como 'false')")
    end

  end

  def accounts_should_include_pdh(accounts)
    count = count_payment_false_values(accounts)

    if count == 0
      fail("Las cuentas resultantes no incluyen ninguna cuenta PDH (Todos los valores Payment están seteados como 'true')")
    end

  end

  def accounts_should_include_only_one_pdh(accounts)
    count = count_payment_true_values(accounts)

    if count != 1
      fail("La cuenta resultante no se mostraría en el combo de Payment Accunts (Su valor Payment está seteado como 'false')")
    end
  end

  def accounts_should_include_only_pdh(accounts)
    count_true = count_payment_true_values(accounts)
    count_false = count_payment_false_values(accounts)

    if count_true == 0 || count_false != 0
      fail("La cuenta resultante no se mostraría en el combo de Payment Accunts (Su valor Payment está seteado como 'false')")
    end
  end

end
World(Accounts_Api)