require_relative 'database_connection'

# top level comment
class User
  attr_reader :user_id, :name, :email

  def initialize(user_id:, name:, email:)
    @user_id = user_id
    @name = name
    @email = email
  end

  def self.create(name:, email:, password:)
    result = DatabaseConnection.query("
      INSERT INTO users (name, email, password)
      VALUES('#{name.gsub("'","''")}', '#{email.gsub("'","''")}', '#{password.gsub("'","''")}')
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

  def self.authenticate(email:, password:)
    result = DatabaseConnection.query("
      SELECT * FROM users
      WHERE email = '#{email.gsub("'","''")}' AND password = '#{password.gsub("'","''")}'
      ").first
    return if result.nil?
    User.new(
      user_id: result['user_id'],
      name: result['name'],
      email: result['email']
    )
  end
end
