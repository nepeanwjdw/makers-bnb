feature 'Signing in to Makers BnB' do
  scenario 'users should be able to sign in' do
    User.create(name: 'Test User', email: 'test@user.com', password: 'password')
    visit('/sign_in')
    fill_in('email', with: 'test@user.com')
    fill_in('password', with: 'password')
    click_on('Submit')
    expect(current_path).to eq('/')
  end
end
