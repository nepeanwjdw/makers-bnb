feature 'Signing in to Makers BnB' do
  scenario 'users should be able to sign in' do
    create_test_user
    visit('/sign_in')
    fill_in('email', with: 'test@test.com')
    fill_in('password', with: 'test123')
    click_on('Submit')
    expect(current_path).to eq('/view_all_spaces')
  end
end
