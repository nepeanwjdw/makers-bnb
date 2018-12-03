require 'database_helpers'
require_relative '../setup_test_spaces_database'
require 'Space'

feature 'creating a new space' do

  before(:each) do
    setup_test_spaces_database
  end

  scenario 'it will add user input to the database' do
    name = "Makers"
    description = "Great!"
    price = 49.99
    user_id = 1
    visit '/create-space'
    fill_in 'name', with: name
    fill_in 'description', with: description
    fill_in 'price', with: price
    click_button "Submit"

    space = Space.create(name: name, description: description, price: price, user_id: user_id)

    expect(space.name).to eq(name)
    expect(space.description).to eq(description)
    expect(space.price).to eq(price)
    expect(space.user_id).to eq(user_id)
  end
end
