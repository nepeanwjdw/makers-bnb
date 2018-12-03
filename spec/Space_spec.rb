require 'spec_helper'
require 'database_helpers'
require 'Space'

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

end
