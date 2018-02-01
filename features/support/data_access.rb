module Data_Access

  def self.load
    begin
      students_list = get_data_from_directory("#{Dir.pwd}/config/data/customers/*_user.yml")
      @@data = {}
      @@data[:students] = students_list
      @@data[:students].each do |student|
        symbolize!(student)
      end


      courses_list = get_data_from_directory("#{Dir.pwd}/config/data/customers/courses.yml")
      @@data[:courses] = courses_list.first['courses']
      @@data[:courses].each do |course|
        symbolize!(course)
      end

      teachers_list = get_data_from_directory("#{Dir.pwd}/config/data/customers/teachers.yml")
      @@data[:teachers] = teachers_list.first['teachers']
      @@data[:teachers].each do |teacher|
        symbolize!(teacher)
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

  def self.get_data_from_directory(directory)
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
    @@data[:students].select { |user| "#{user[:first_name]} #{user[:last_name]}" == user_name }.first
  end


  def self.get_courses
    @@data[:courses]
  end

  def self.get_teachers
    @@data[:teachers]
  end

  def self.get_students
    @@data[:students]
  end

  def self.get_teacher(teacher_name)
    @@data[:teachers].select { |teacher| teacher[:first_name]  == teacher_name }.first
  end

  def self.get_course(course_name)
    @@data[:courses].select {|course| course[:name] == course_name}.first
  end



end