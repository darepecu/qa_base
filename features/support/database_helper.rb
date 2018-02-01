require 'active_record'

module Database_Helper


  def clean_database(table_list=nil)
    if table_list.nil?
      table_list = %w{ ALUMNO CURSO DOCENTE ALUMNO_CURSO }
    end

    table_list.each do |table_name|
      table = "testdb.#{table_name}"
      ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS = 0;")
      ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table};")
      ActiveRecord::Base.connection.execute("SET FOREIGN_KEY_CHECKS = 1;")
    end
  end

  def create_full_data
    create_student
    create_teacher
    create_course
  end

  def create_teacher
    Data_Access::get_teachers.each do |teacher|
      teacher_entity = Teacher.create(first_name: teacher[:first_name], last_name: teacher[:last_name], second_last_name: teacher[:second_last_name], code: teacher[:code], document_id: teacher[:document_id])
    end
  end

  def create_student
    Data_Access::get_students.each do |student|
      student_entity = Student.create(first_name: student[:first_name], last_name: student[:last_name], second_last_name: student[:second_last_name], code: student[:code], sex: student[:sex], address: student[:address], document_id: student[:document_id], grade: student[:grade])
    end
  end

  def create_course
    Data_Access::get_courses.each do |course|
      teacher_id = get_teacherid_by_name(course[:teacher])
      course_entity = Course.create(name: course[:name], code: course[:code], description: course[:description], teacher_id: teacher_id)

      course[:students].each do |student|
        student_id = get_studentid_by_name(student[:first_name])
        create_student_course(student_id, course_entity.id)
      end

    end
  end

  def create_student_course(student_id,course_id)
    student_course_entity = Student_Course.create(student_id: student_id, course_id: course_id)
  end

  def get_teacherid_by_name(teacher_name)
    teacher=Teacher.where(first_name: teacher_name).first
    if teacher != nil
      teacher[:id]
    else
      fail("No teacher with these characteristics were found")
    end
  end

  def get_studentid_by_name(student_name)
    student=Student.where(first_name: student_name).first
    if student != nil
      student[:id]
    else
      fail("No student with these characteristics were found")
    end
  end

  def query_example
    Student.find_by_sql("Select * from ALUMNO")
  end

end
World(Database_Helper)
