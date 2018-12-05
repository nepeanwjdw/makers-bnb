require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec('TRUNCATE users, spaces, space_dates, bookings CASCADE;')
end

def create_test_user
  connection = PG.connect(dbname: 'makers_bnb_test')
  connection.exec("
        INSERT INTO users (user_id, name, email, password)
        VALUES(15, 'Test user', 'test@test.com', 'test123')
        RETURNING user_id, name, email;
        ").first
end

def create_test_user_from_frontend
    visit('/sign_up')
    fill_in('name', with: 'Test User')
    fill_in('email', with: 'test@email.com')
    fill_in('password', with: 'password')
    click_on('Submit')
    User.retrieve_by_email(email: 'test@email.com')
end
