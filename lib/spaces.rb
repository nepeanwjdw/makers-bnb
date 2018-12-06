require_relative 'database_connection'

# top level comment
class Space
  attr_reader :space_id, :name, :description, :price, :user_id, :image

  def initialize(space_id:, name:, description:, price:, user_id:)
    @space_id = space_id.to_i
    @name = name
    @description = description
    @price = price.to_f
    @user_id = user_id.to_i
    @image = image
  end

  def price_currency
    "£#{'%.2f' % @price}"
  end

  def self.check_available_on_date(space_id:, date:)
    # use self.get_all_booking_dates to get array of dates for space_id
    # check to see if date is in the array
    # return true/false accordingly
  end

  def self.get_bookings_for_space(space_id:)
    DatabaseConnection.query("
      SELECT *
      FROM bookings
      WHERE space_id = '#{space_id}'
      ").map do |row|
      Booking.new(
        booking_request_id: row['booking_request_id'],
        booker_user_id: row['booker_user_id'],
        space_id: row['space_id'],
        booking_start_date: row['booking_start_date'],
        booking_end_date: row['booking_end_date'],
        booking_confirmed: row['booking_confirmed']
      )
    end
  end

  def self.get_available_dates(space_id:)
    availability = check_availability(space_id: space_id).first
    start_date = DateTime.strptime(availability['start_date'], "%Y-%m-%d")
    end_date = DateTime.strptime(availability['end_date'], "%Y-%m-%d")
    available_range = (start_date..end_date).map do |date|
      date.strftime("%Y-%m-%d").to_s
    end
    bookings = get_confirmed_bookings_for_space(space_id: space_id)
    available_range - get_all_booking_dates(bookings: bookings)
  end

  def self.get_confirmed_bookings_for_space(space_id:)
    get_bookings_for_space(space_id: space_id).select{ |i| i.confirmed? }.map do |booking|
      booking
    end
  end

  def self.get_all_booking_dates(bookings:)
    bookings.map do |booking|
      booking.return_dates
    end.flatten.sort
  end

  def self.get_bookings_for_user(user_id:)
    DatabaseConnection.query("
      SELECT *
      FROM bookings
      WHERE user_id = '#{user_id}'
      ").map do |row|
      Booking.new(
        booking_request_id: row['booking_request_id'],
        booker_user_id: row['booker_user_id'],
        space_id: row['space_id'],
        booking_start_date: row['booking_start_date'],
        booking_end_date: row['booking_end_date'],
        booking_confirmed: row['booking_confirmed']
      )
    end
  end

  def self.all
    DatabaseConnection.query("
      SELECT users.user_id, users.name
      AS username, users.email, spaces.space_id, spaces.name
      AS spacename, spaces.description, spaces.price, spaces.image
      FROM spaces
      INNER JOIN users ON spaces.user_id=users.user_id
      ORDER BY spaces.space_id ASC;")
  end

  def self.get_space_info(space_id:)
    DatabaseConnection.query("
      SELECT users.user_id, users.name
      AS username, users.email, spaces.space_id, spaces.name
      AS spacename, spaces.description, spaces.price
      FROM spaces
      INNER JOIN users ON spaces.user_id=users.user_id
      WHERE spaces.space_id = '#{space_id}';").first
  end

  def self.allFromHost(user_id:)
    DatabaseConnection.query("
      SELECT users.user_id, users.name
      AS username, users.email, spaces.space_id, spaces.name
      AS spacename, spaces.description, spaces.price, spaces.image
      FROM spaces
      INNER JOIN users ON spaces.user_id=users.user_id
      WHERE spaces.user_id='#{user_id}'
      ORDER BY spaces.space_id ASC;")
  end

  def self.create(name:, description:, price:, user_id:, image:)

    result = DatabaseConnection.query("
      INSERT INTO spaces (name, description, price, user_id, image)
      VALUES('#{name.gsub("'","''")}', '#{description.gsub("'","''")}', '#{price}', '#{user_id}', '#{image}')
      RETURNING space_id, name, description, price, user_id, image;")
    Space.new(
      space_id: result[0]['space_id'], name: result[0]['name'],
      description: result[0]['description'], price: result[0]['price'],
      user_id: result[0]['user_id']
    )
  end

  def self.create_availability(space_id:, start_date:, end_date:)
    DatabaseConnection.query("
      INSERT INTO space_dates (space_id, start_date, end_date)
      VALUES('#{space_id}', '#{start_date}', '#{end_date}')
      RETURNING space_id, start_date, end_date
      ").first
  end

  def self.check_availability(space_id:)
    DatabaseConnection.query("
      SELECT *
      FROM space_dates
      WHERE space_id = '#{space_id}'
      ").map do |row|
      row
    end
  end

end
