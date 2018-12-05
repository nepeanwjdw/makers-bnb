require_relative 'database_connection'

# top level comment
class Booking
  def self.available_dates(space_id)
    dates_included = []
    dates_excluded = []
    dates_list = []
    results_a = DatabaseConnection.query("
      SELECT start_date, end_date
      FROM space_dates
      WHERE space_id = '#{space_id}';
    ")

    results_a.map do |range|
      start_date_a = range['start_date']
      end_date_a = range['end_date']
      a = Date.parse(start_date_a)
      b = Date.parse(end_date_a)
      while a < b do
        dates_included << a
        a += 1
      end
      dates_included << b
    end

    results_b = DatabaseConnection.query("
      SELECT booking_start_date, booking_end_date
      FROM bookings WHERE space_id = '#{space_id}' AND booking_confirmed = 'TRUE';
    ")

    results_b.map do |range|
      start_date_b = range['booking_start_date']
      end_date_b = range['booking_end_date']
      a = Date.parse(start_date_b)
      b = Date.parse(end_date_b)
      while a < b do
        dates_excluded << a
        a += 1
      end
      dates_excluded << b
    end

    included = dates_included.uniq.sort!
    excluded = dates_excluded.uniq.sort!

    included.each do |a_date|
      if !excluded.include?(a_date)
        dates_list << a_date.strftime("%d/%m/%Y")
      end
    end

    return dates_list
  end
end
