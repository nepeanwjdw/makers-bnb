CREATE TABLE space_dates(
  date_id SERIAL PRIMARY KEY,
  space_id INT,
  start_date DATE,
  end_date DATE,
  FOREIGN KEY (space_id) REFERENCES spaces (space_id)
);
