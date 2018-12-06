feature 'Host Dashboard' do
  background do
    user = create_test_user_from_frontend
    Space.create(
      name: 'Makers!',
      description: 'Great!',
      price: 49.99,
      user_id: user.user_id
    )
    Space.create(
      name: 'The Ritz Flat',
      description: 'Snazzy!',
      price: 89.99,
      user_id: user.user_id
    )
    visit('/host_dashboard')
  end

  scenario 'hosts should be able to edit their Name' do
    expect(page).to have_selector("input[value='Test User']")
    fill_in('user_name', with: 'John')
    click_on('Update Profile')
    expect(page).to have_selector("input[value='John']")
  end

  scenario 'hosts should be able to edit their Email' do
    expect(page).to have_selector("input[value='test@email.com']")
    fill_in('user_email', with: 'john@email.com')
    click_on('Update Profile')
    expect(page).to have_selector("input[value='john@email.com']")
  end

  xscenario 'hosts should be able to view incoming Booking Requests' do

  end

  xscenario 'hosts should be able to view outgoing Booking Requests' do

  end

  scenario 'hosts should be able to view a list of their spaces to edit' do
    expect(page).to have_content('Makers!')
    expect(page).to have_content('The Ritz Flat')
    expect(page).to have_button('Edit')
  end
end
