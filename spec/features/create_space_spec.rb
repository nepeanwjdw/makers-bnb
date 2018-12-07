feature 'creating a new space' do
  scenario 'it will add user input to the database' do
    user = create_test_user_from_frontend
    name = 'Makers'
    description = 'Great!'
    price = 49.99
    start_date = '2018-01-15'
    end_date = '2018-01-22'
    visit '/create_space'
    fill_in 'name', with: name
    fill_in 'description', with: description
    fill_in 'price', with: price
    fill_in 'daterange', with: "#{start_date} - #{end_date}"
    click_button 'Submit'

    space = Space.create(
      name: name,
      description: description,
      price: price,
      user_id: user.user_id,
      image: 'duck.jpg'
    )

    expect(space.name).to eq(name)
    expect(space.description).to eq(description)
    expect(space.price).to eq(price)
    expect(space.user_id).to eq(user.user_id.to_i)
  end
end
