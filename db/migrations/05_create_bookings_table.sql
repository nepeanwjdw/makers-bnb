CREATE TABLE bookings(
  booking_request_id SERIAL PRIMARY KEY,
  booker_user_id INT,
  space_id INT,
  booking_start_date DATE,
  booking_end_date DATE,
  booking_confirmed BOOLEAN,
  FOREIGN KEY (space_id) REFERENCES spaces (space_id)
);
