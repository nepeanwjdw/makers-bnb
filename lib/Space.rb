require_relative 'DatabaseConnection'

class Space

  attr_reader :space_id, :name, :description, :price, :start_date, :end_date, :user_id

  def initialize(space_id:, name:, description:, price:, start_date: nil, end_date: nil, user_id:)
    @space_id = space_id.to_i
    @name = name
    @description = description
    @price = price.to_f
    @start_date = start_date
    @end_date = end_date
    @user_id = user_id.to_i
  end

  def self.create(name:, description:, price:, start_date: nil, end_date: nil, user_id:)
    result = DatabaseConnection.query("INSERT INTO spaces (name, description, price, user_id) VALUES('#{name}', '#{description}', #{price}, '#{user_id}') RETURNING space_id, name, description, price, user_id")
    Space.new(space_id: result[0]['space_id'], name: result[0]['name'], description: result[0]['description'], price: result[0]['price'], user_id: result[0]['user_id'])
  end

  def self.all
    results = DatabaseConnection.query("SELECT users.user_id, users.name AS username, users.email, spaces.space_id, spaces.name AS spacename, spaces.description, spaces.price FROM spaces INNER JOIN users ON spaces.user_id=users.user_id ORDER BY spaces.space_id ASC;")
  end
end
