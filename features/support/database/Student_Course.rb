class Student_Course < ActiveRecord::Base
  self.table_name = 'ALUMNO_CURSO'

  alias_attribute :student_id, :ALUMNO_ID
  alias_attribute :course_id, :CURSO_ID

  belongs_to :teacher
  belongs_to :course

end