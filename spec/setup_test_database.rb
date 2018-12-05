require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec('TRUNCATE users, spaces, space_dates, bookings;')
end

def create_test_user
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec("
        INSERT INTO users (user_id, name, email, password)
        VALUES(15, 'Test user', 'test@test.com', 'test123')
        RETURNING user_id, name, email;
        ").first
end
