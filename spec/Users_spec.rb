require 'database_helpers'
require 'users'

describe User do
  describe '.create' do
    it 'creates a new user' do
      user = User.create(
        name: 'Test user',
        email: 'test@test.com',
        password: 'test123'
      )
      pud = persisted_users_data(user_id: user.user_id)
      expect(user).to be_a User
      expect(user.user_id).to eq pud['user_id']
      expect(user.name).to eq 'Test user'
      expect(user.email).to eq 'test@test.com'
    end
  end

  describe '.retrieve' do
    it 'retrieves user details from server' do
      create_test_user
      retrieved_user = User.retrieve(user_id: 15)
      pud = persisted_users_data(user_id: retrieved_user.user_id)
      expect(retrieved_user).to be_a User
      expect(retrieved_user.user_id).to eq pud['user_id']
      expect(retrieved_user.name).to eq 'Test user'
      expect(retrieved_user.email).to eq 'test@test.com'
    end
  end

  describe '.authenticate' do
    it 'authenticates a user' do
      create_test_user
      authenticated_user = User.authenticate(
        email: 'test@test.com', password: 'test123'
      )
      expect(authenticated_user).to be_a User
      expect(authenticated_user.user_id).to eq '15'
      expect(authenticated_user.name).to eq 'Test user'
      expect(authenticated_user.email).to eq 'test@test.com'
    end
  end

  describe '.update_name_email' do
    it 'updates the name and email in the database' do
      user = create_test_user
      User.update_name_email(
        user_id: user['user_id'],
        new_name: 'John',
        new_email: 'john@email.com'
      )
      updated_user = persisted_users_data(user_id: user['user_id'])
      expect(updated_user['name']).to eq 'John'
      expect(updated_user['email']).to eq 'john@email.com'
    end
  end
end
