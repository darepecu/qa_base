class Course < ActiveRecord::Base
  self.table_name = 'CURSO'
  self.primary_key = 'ID'

  alias_attribute :name, :NOMBRE
  alias_attribute :code, :CODIGO
  alias_attribute :description, :DESCRIPCION
  alias_attribute :teacher_id, :DOCENTE_ID

  belongs_to :teacher

end