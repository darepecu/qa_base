module Data_Access

  def self.load
    begin
      customers_list = get_users_from_directory("#{Dir.pwd}/config/data/customers/*.yml")
      @@data = {}
      @@data[:users] = customers_list
      @@data[:users].each do |user|
        symbolize!(user)
      end

      true
    rescue => error
      puts "There was a problem loading the test data. \n #{error.to_s}"
      false
    end
  end

  def self.symbolize!(hash)
    hash.keys.each do |key|
      case hash[key]
        when Hash
          new_key = key.respond_to?(:to_sym) ? key.to_sym : key
          hash[new_key] = hash.delete(key)
          symbolize!(hash[new_key])
        when Array
          new_key = key.respond_to?(:to_sym) ? key.to_sym : key
          hash[new_key] = hash.delete(key)
          hash[new_key].each do |item|
            symbolize!(item)
          end
        else
          new_key = key.respond_to?(:to_sym) ? key.to_sym : key
          hash[new_key] = hash.delete(key)
      end
    end

  end

  def self.get_users_from_directory(directory)
    user_files_list = Dir[directory]
    users_list = []
    user_files_list.each do |user_file_name|
      user_info = YAML.load_file("#{user_file_name}")
      if user_info!=false
        users_list.push(user_info)
      end
    end
    users_list
  end

  def self.get_user(user_name)
    @@data[:users].select { |user| "#{user[:first_name]} #{user[:last_name]}" == user_name }.first
  end

end