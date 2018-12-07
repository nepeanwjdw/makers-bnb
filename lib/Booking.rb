require_relative 'database_connection'
require 'date'
require 'email'

# top level comment
class Booking

  attr_reader :booking_request_id, :booker_user_id, :space_id, :booking_start_date, :booking_end_date, :booking_confirmed

  def initialize(booking_request_id:, booker_user_id:, space_id:, booking_start_date:, booking_end_date:, booking_confirmed:)
    @booking_request_id = booking_request_id
    @booker_user_id = booker_user_id
    @space_id = space_id
    @booking_start_date = booking_start_date
    @booking_end_date = booking_end_date
    @booking_confirmed = booking_confirmed
  end

  def return_dates
    start_date = DateTime.strptime(@booking_start_date, "%Y-%m-%d")
    end_date = DateTime.strptime(@booking_end_date, "%Y-%m-%d")
    (start_date..end_date).map do |date|
      date.strftime("%Y-%m-%d").to_s
    end
  end

  def confirmed?
    @booking_confirmed == "t"
  end

  def self.confirm_booking(booking_id:, booker_id:, host_id:)
    DatabaseConnection.query("
      UPDATE bookings
      SET booking_confirmed = true
      WHERE booking_request_id = #{booking_id};
    ")
    booker_email = User.retrieve(user_id: booker_id).email
    host_email = User.retrieve(user_id: host_id).email
    Email.create(booker_email, "request_confirmed")
    Email.create(host_email, "confirm_request")
  end

  def self.reject_booking(booking_id:, booker_id:)
    DatabaseConnection.query("
      DELETE FROM bookings
      WHERE booking_request_id = #{booking_id};
    ")
    booker_email = User.retrieve(user_id: booker_id).email
    Email.create(booker_email, "request_denied")
  end

  def self.create_booking_request(booker_user_id:, space_id:, booking_start_date:, booking_end_date: nil)
    # following line handles current functionality where booking is just one day
    booking_end_date = booking_start_date if booking_end_date == nil
    booking_confirmed = false

    result = DatabaseConnection.query("
      INSERT INTO bookings (booker_user_id, space_id, booking_start_date, booking_end_date, booking_confirmed)
      VALUES('#{booker_user_id}', '#{space_id}', '#{booking_start_date}', '#{booking_end_date}', '#{booking_confirmed}')
      RETURNING booking_request_id, booker_user_id, space_id, booking_start_date, booking_end_date, booking_confirmed;
    ")
    Booking.new(
      booking_request_id: result[0]['booking_request_id'],
      booker_user_id: result[0]['booker_user_id'],
      space_id: result[0]['space_id'],
      booking_start_date: result[0]['booking_start_date'],
      booking_end_date: result[0]['booking_end_date'],
      booking_confirmed: result[0]['booking_confirmed']
    )
  end

  def self.view_incoming(host_user_id:)
    DatabaseConnection.query("
      SELECT
        booking_request_id,
        booker_user_id,
        users.name AS booker_name,
        spaces.space_id,
        spaces.name AS space_name,
        booking_start_date,
        booking_end_date,
        spaces.user_id AS host_user_id,
        booking_confirmed
      FROM
        bookings
        JOIN spaces ON bookings.space_id = spaces.space_id
        JOIN users ON bookings.booker_user_id = users.user_id
      WHERE
        spaces.user_id = '#{host_user_id}'
        AND booking_confirmed = FALSE
    ")
  end

  def self.view_outgoing(booker_user_id:)
    # code here to see requests you've made
  end
end
