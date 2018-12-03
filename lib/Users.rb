require 'pg'
require_relative 'DatabaseConnection'

class User

  attr_reader :id, :name, :email

  def self.create(name:, email:, password:)
    result = DatabaseConnection.query("INSERT INTO users (name, email, password) VALUES('#{name}', '#{email}', '#{password}') RETURNING user_id, name, email;")
  end

end
