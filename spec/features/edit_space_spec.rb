require 'pg'

feature 'editing a space' do
  scenario 'allows a user to edit an exiting space' do
    create_test_user
    create_test_space
    visit('/sign_in')
    fill_in('email', with: 'test@test.com')
    fill_in('password', with: 'test123')
    click_on('Submit')
    visit('/host_dashboard')
    click_button('Edit')
    fill_in('name', with: 'Bakers MNM')
    fill_in('description', with: 'Nice space to stay')
    fill_in('price', with: 88)
    click_on('Submit')

    connection = PG.connect(dbname: 'makers_bnb_test')
    result = connection.query("SELECT * FROM spaces WHERE user_id = 15")
    
    expect(result[0]['name']).to eq('Bakers MNM')
    expect(result[0]['description']).to eq('Nice space to stay')
    expect(result[0]['price']).to eq('88')
  end
end