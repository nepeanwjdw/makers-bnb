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

  describe '.retrieve' do
    it 'retrieves user details from server' do
      user = User.create(name: 'Test User', email: 'test@user.com', password: 'password')
      retrieved_user = User.retrieve(user_id: user.user_id)
      pud = persisted_users_data(user_id: retrieved_user.user_id)
      expect(retrieved_user).to be_a User
      expect(retrieved_user.user_id).to eq pud['user_id']
      expect(retrieved_user.name).to eq 'Test User'
      expect(retrieved_user.email).to eq 'test@user.com'
    end
  end

  describe '.authenticate' do
    it 'authenticates a user' do
      user = User.create(name: 'Test User', email: 'test@user.com', password: 'password')
      authenticated_user = User.authenticate(email: 'test@user.com', password: 'password')
      pud = persisted_users_data(user_id: authenticated_user.user_id)
      expect(authenticated_user).to be_a User
      expect(authenticated_user.user_id).to eq pud['user_id']
      expect(authenticated_user.name).to eq 'Test User'
      expect(authenticated_user.email).to eq 'test@user.com'
    end
  end
end
