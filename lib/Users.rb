require 'pg'
require_relative 'DatabaseConnection'

class User

  attr_reader :user_id, :name, :email

  def initialize(user_id:, name:, email:)
    @user_id = user_id
    @name = name
    @email = email
  end

  def self.create(name:, email:, password:)
    result = DatabaseConnection.query("INSERT INTO users (name, email, password) VALUES('#{name}', '#{email}', '#{password}') RETURNING user_id, name, email;")
    User.new(user_id: result[0]['user_id'], name: result[0]['name'], email: result[0]['email'])
  end
end
