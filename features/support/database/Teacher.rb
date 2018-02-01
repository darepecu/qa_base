class Teacher < ActiveRecord::Base
  self.table_name = 'DOCENTE'
  self.primary_key = 'ID'

  alias_attribute :first_name, :NOMBRE
  alias_attribute :last_name, :APELLIDO_PATERNO
  alias_attribute :second_last_name, :APELLIDO_MATERNO
  alias_attribute :code, :CODIGO
  alias_attribute :document_id, :DNI

  has_many :courses

end