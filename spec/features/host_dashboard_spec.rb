feature 'Host Dashboard' do
  background do
    user = create_test_user
    visit('/host_dashboard')
    Space.create(
      name: 'Makers!',
      description: 'Great!',
      price: 49.99,
      user_id: user['user_id']
    )
    Space.create(
      name: 'The Ritz Flat',
      description: 'Snazzy!',
      price: 89.99,
      user_id: user['user_id']
    )
  end

  xscenario 'hosts should be able to edit their Name' do

  end

  xscenario 'hosts should be able to edit their Email' do

  end

  xscenario 'hosts should be able to edit their Password' do

  end

  xscenario 'hosts should be able to view Booking Requests' do

  end

  scenario 'hosts should be able to view a list of their spaces to edit' do
    expect(page).to have_content('Makers!')
    expect(page).to have_content('The Ritz Flat')
    expect(page).to have_button('Edit')
  end
end
