require 'Users'
require 'database_helpers'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(name: 'Test User', email: 'test@user.com', password: 'password')
      pud = persisted_users_data(user_id: user.user_id)
      expect(user).to be_a User
      expect(user.user_id).to eq pud['user_id']
      expect(user.name).to eq 'Test User'
      expect(user.email).to eq 'test@user.com'
    end
  end

  describe '.fetch' do
    it 'fetches user details from server' do
      User.create(name: 'Test User', email: 'test@user.com', password: 'password')
      user = User.fetch(email: 'test@user.com', password: 'password')
      pud = persisted_users_data(user_id: user.user_id)
      expect(user).to be_a User
      expect(user.user_id).to eq pud['user_id']
      expect(user.name).to eq 'Test User'
      expect(user.email).to eq 'test@user.com'
    end
  end
end
