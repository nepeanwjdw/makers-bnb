require 'spec_helper'
require 'database_helpers'
require 'Space'
require './lib/DatabaseConnection'

describe Space do

  before(:each) do
    setup_test_spaces_database
  end

  describe 'space' do
    it 'can be created' do
      name = "Makers BNB"
      description = "Lovely space to stay"
      price = 99
      user_id = 1

      space = Space.create(name: name, description: description, price: price, user_id: user_id)

      expect(space).to be_a Space
      expect(space.name).to eq name
      expect(space.description).to eq description
      expect(space.price).to eq price
      expect(space.user_id).to eq user_id
    end
  end

  describe '.all' do
    it 'shows all spaces' do
      DatabaseConnection.query("INSERT INTO users (user_id, name, email, password) VALUES(15, 'Test User', 'test@user.com', 'password');")
      space_a = DatabaseConnection.query("INSERT INTO spaces (name, description, price, user_id) VALUES('Makers!', 'Great!', 49.99, 15) RETURNING space_id, name, description, price, user_id")
      space_b = DatabaseConnection.query("INSERT INTO spaces (name, description, price, user_id) VALUES('The Ritz Flat', 'Snazzy!', 89.99, 15) RETURNING space_id, name, description, price, user_id")
      spaces = Space.all

      expect(spaces.length).to eq 2
      expect(spaces.first).to be_a Space
      expect(spaces.first.space_id).to eq space_a[0]["space_id"].to_i
      expect(spaces.first.user_id).to eq 15
      expect(spaces.first.description).to eq 'Great!'
      expect(spaces.first.price).to eq 49.99
    end
  end
end
