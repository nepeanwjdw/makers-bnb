feature 'Signing up for Makers BnB' do
  scenario 'users should be able to create an account' do
    visit('/sign_up')
    fill_in('name', with: 'Test User')
    fill_in('email', with: 'test@email.com')
    fill_in('password', with: 'password')
    click_on('Submit')
    expect(current_path).to eq('/')
  end
end
