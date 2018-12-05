feature 'creating a new space' do
  scenario 'it will add user input to the database' do
    create_test_user
    name = 'Makers'
    description = 'Great!'
    price = 49.99
    user_id = 15
    visit '/create_space'
    fill_in 'name', with: name
    fill_in 'description', with: description
    fill_in 'price', with: price
    click_button 'Submit'

    space = Space.create(
      name: name,
      description: description,
      price: price,
      user_id: user_id
    )

    expect(space.name).to eq(name)
    expect(space.description).to eq(description)
    expect(space.price).to eq(price)
    expect(space.user_id).to eq(user_id)
  end
end
