class Student < ActiveRecord::Base
  self.table_name = 'ALUMNO'
  self.primary_key = 'ID'

  alias_attribute :first_name, :NOMBRE
  alias_attribute :last_name, :APELLIDO_PATERNO
  alias_attribute :second_last_name, :APELLIDO_MATERNO
  alias_attribute :code, :CODIGO
  alias_attribute :sex, :SEXO
  alias_attribute :address, :DIRECCION
  alias_attribute :document_id, :DNI
  alias_attribute :grade, :GRADO

end