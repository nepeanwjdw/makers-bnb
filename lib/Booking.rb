require_relative 'database_connection'
require 'date'

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
    end_date = DateTime.strptime(@booking_end_date, "%Y-%m=%d")
    (start_date..end_date).map do |date|
      date.strftime("%Y-%m-%d").to_s
    end
  end

  def self.create_booking_request(booker_user_id:, space_id:, booking_start_date:, booking_end_date: nil)
    # following line handles current functionality where booking is just one day
    booking_end_date = booking_start_date if booking_end_date == nil
    booking_confirmed = false

    result = DatabaseConnection.query("
      INSERT INTO bookings (booker_user_id, space_id, booking_start_date, booking_end_date, booking_confirmed)
      VALUES('#{booker_user_id}', '#{space_id}', '#{booking_start_date}', '#{booking_end_date}', #{booking_confirmed})
      RETURNING booking_request_id, booker_user_id, space_id, booking_start_date, booking_end_date, booking_confirmed;")
    Booking.new(
      booking_request_id: result[0]['booking_request_id'],
      booker_user_id: result[0]['booker_user_id'],
      space_id: result[0]['space_id'],
      booking_start_date: result[0]['booking_start_date'],
      booking_end_date: result[0]['booking_end_date'],
      booking_confirmed: result[0]['booking_confirmed']
    )
  end

end
