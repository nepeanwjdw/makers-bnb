require_relative 'database_connection'
require 'bcrypt'

# top level comment
class User
  attr_reader :user_id, :name, :email

  def initialize(user_id:, name:, email:)
    @user_id = user_id
    @name = name
    @email = email
  end

  def self.create(name:, email:, password:)
    return nil if User.retrieve_by_email(email: email)
    hashed_password = BCrypt::Password.create(password)
    result = DatabaseConnection.query("
      INSERT INTO users (name, email, password)
      VALUES('#{name.gsub("'","''")}', '#{email.gsub("'","''")}', '#{hashed_password}')
      RETURNING user_id, name, email;
      ").first
    User.new(
      user_id: result['user_id'],
      name: result['name'],
      email: result['email']
    )
  end

  def self.retrieve(user_id:)
    return nil unless user_id
    result = DatabaseConnection.query("
      SELECT * FROM users
      WHERE user_id = '#{user_id}';
      ").first
    User.new(
      user_id: result['user_id'],
      name: result['name'],
      email: result['email']
    )
  end

  def self.retrieve_by_email(email:)
    return nil unless email
    result = DatabaseConnection.query("
      SELECT * FROM users
      WHERE email = '#{email}';
      ").first
      p result
    return if result == nil
    User.new(
      user_id: result['user_id'],
      name: result['name'],
      email: result['email']
    )
  end

  def self.authenticate(email:, password:)
    result = DatabaseConnection.query("
      SELECT * FROM users
      WHERE email = '#{email.gsub("'","''")}'
      ").first
    return if result.nil?
    return unless BCrypt::Password.new(result['password']) == password
    User.new(
      user_id: result['user_id'],
      name: result['name'],
      email: result['email']
    )
  end

  def self.update_name_email(user_id:, new_name:, new_email:)
    DatabaseConnection.query("
      UPDATE Users
      SET name= '#{new_name.gsub("'","''")}', email= '#{new_email.gsub("'","''")}'
      WHERE user_id = '#{user_id}';
    ")
  end
end
