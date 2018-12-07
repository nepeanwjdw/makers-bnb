feature 'view spaces' do
  scenario 'page displays a list of available spaces' do
    user = create_test_user
    Space.create(
      name: 'Makers!',
      description: 'Great!',
      price: 49.99,
      user_id: user['user_id'],
      image: 'duck.jpg'
    )
    Space.create(
      name: 'The Ritz Flat',
      description: 'Snazzy!',
      price: 89.99,
      user_id: user['user_id'],
      image: 'duck.jpg'
    )
    visit('/view_all_spaces')
    expect(page).to have_content('Makers!')
    expect(page).to have_content('Great!')
    expect(page).to have_content('49.99')
    expect(page).to have_content('The Ritz Flat')
    expect(page).to have_content('Snazzy!')
    expect(page).to have_content('89.99')
    expect(page).to have_content('Test user')
    expect(page).to have_content('test@test.com')
  end
end
