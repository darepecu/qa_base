require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => "mysql2",
    :host => FigNewton.db_host,
    :database => FigNewton.db_name,
    :username => FigNewton.db_user,
    :password => FigNewton.db_password
)