require 'Users'

describe User do
  describe '.create' do
    it 'creates a new user' do
      User.create(name: 'Test User', email: 'test@user.com', password: 'password')
      # persisted_users_data = persisted_users_data(id: user.id)
      connection = PG.connect(dbname: "makers_bnb_test")
      result = connection.query("SELECT * FROM users WHERE email = 'test@user.com';").first
      # expect(user).to be_a User
      # expect(result.user_id).to eq result['user_id']
      expect(result['name']).to eq 'Test User'
      expect(result['email']).to eq 'test@user.com'
    end
  end
end
