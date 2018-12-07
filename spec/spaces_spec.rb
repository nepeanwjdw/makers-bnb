require 'database_helpers'
require 'spaces'

describe Space do
  describe 'space' do
    it 'can be created' do
      test_user = create_test_user
      name = 'Makers BNB'
      description = 'Lovely space to stay'
      price = 99
      user_id = test_user['user_id']
      image = 'duck.jpg'

      space = Space.create(
        name: name,
        description: description,
        price: price,
        user_id: user_id,
        image: image
      )

      expect(space).to be_a Space
      expect(space.name).to eq name
      expect(space.description).to eq description
      expect(space.price).to eq price
      expect(space.user_id).to eq user_id.to_i
    end
  end

  describe 'dates' do
    it 'a date range can be created' do
      test_user = create_test_user
      name = 'Makers BNB'
      description = 'Lovely space to stay'
      price = 99
      user_id = test_user['user_id']
      image = 'duck.jpg'

      space = Space.create(
        name: name,
        description: description,
        price: price,
        user_id: user_id,
        image: image
      )

      start_date = '2018-01-01'
      end_date = '2018-01-02'
      available = Space.create_availability(
        space_id: space.space_id,
        start_date: start_date,
        end_date: end_date
      )

      expect(available['start_date']).to eq(start_date)
      expect(available['end_date']).to eq(end_date)
    end

    it 'will return a date range' do
      test_user = create_test_user
      create_test_space

      start_date = '2018-01-01'
      end_date = '2018-01-02'
      Space.create_availability(
        space_id: 1,
        start_date: start_date,
        end_date: end_date
      )

      available = Space.check_availability(space_id: 1).first

      expect(available['start_date']).to eq(start_date)
      expect(available['end_date']).to eq(end_date)
      expect(available['space_id']).to eq('1')
    end

    it 'can report all confirmed booked dates' do
      create_test_user
      create_test_space

      start_date = '2018-01-01'
      end_date = '2018-01-02'
      Space.create_availability(
        space_id: 1,
        start_date: start_date,
        end_date: end_date
      )

      

    end
  end

  describe '.all' do
    it 'shows all spaces' do
      DatabaseConnection.query("
        INSERT INTO users (user_id, name, email, password)
        VALUES(15, 'Test User', 'test@user.com', 'password');")
      space_a = DatabaseConnection.query("
        INSERT INTO spaces (name, description, price, user_id)
        VALUES('Makers!', 'Great!', 49.99, 15)
        RETURNING space_id, name, description, price, user_id")
      DatabaseConnection.query("
        INSERT INTO spaces (name, description, price, user_id)
        VALUES('The Ritz Flat', 'Snazzy!', 89.99, 15)
        RETURNING space_id, name, description, price, user_id")
      spaces = Space.all

      expect(spaces.ntuples).to eq 2
      expect(spaces[0]['space_id']).to eq space_a[0]['space_id']
      expect(spaces[0]['user_id']).to eq '15'
      expect(spaces[0]['description']).to eq 'Great!'
      expect(spaces[0]['price']).to eq '49.99'
    end
  end

  describe '.allFromHost' do
    it 'shows all spaces from a specific host' do
      DatabaseConnection.query("
        INSERT INTO users (user_id, name, email, password)
        VALUES(15, 'Test User', 'test@user.com', 'password');")
      DatabaseConnection.query("
        INSERT INTO users (user_id, name, email, password)
        VALUES(16, 'Test User 2', 'test2@user.com', 'password');")
      DatabaseConnection.query("
        INSERT INTO spaces (name, description, price, user_id)
        VALUES('Makers!', 'Great!', 49.99, 16)
        RETURNING space_id, name, description, price, user_id")
      space_a = DatabaseConnection.query("
        INSERT INTO spaces (name, description, price, user_id)
        VALUES('The Ritz Flat', 'Snazzy!', 89.99, 15)
        RETURNING space_id, name, description, price, user_id")
      spaces = Space.allFromHost(user_id: 15)

      expect(spaces.ntuples).to eq 1
      expect(spaces[0]['space_id']).to eq space_a[0]['space_id']
      expect(spaces[0]['user_id']).to eq '15'
      expect(spaces[0]['description']).to eq 'Snazzy!'
      expect(spaces[0]['price']).to eq '89.99'
    end
  end

  describe '.update' do
    it 'updates a space already in the database' do
      create_test_user
      create_test_space

      Space.update(space_id: 1, name: 'Bakers MNM', description: 'Nice space to stay', price: 88, image: 'a_duck.jpg')

      connection = PG.connect(dbname: 'makers_bnb_test')
      result = connection.query("SELECT * FROM spaces WHERE user_id = 15")
      
      expect(result[0]['name']).to eq('Bakers MNM')
      expect(result[0]['description']).to eq('Nice space to stay')
      expect(result[0]['price']).to eq('88')
    end
  end
end
