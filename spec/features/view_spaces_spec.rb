feature "view spaces" do
  scenario "page displays a list of available spaces" do
    user = User.create(name: 'Test User', email: 'test@user.com', password: 'password')
    Space.create(name: "Makers!", description: "Great!", price: 49.99, user_id: user.user_id)
    Space.create(name: "The Ritz Flat", description: "Snazzy!", price: 89.99, user_id: user.user_id)
    visit('/view_all')
    expect(page).to have_content("Makers!")
    expect(page).to have_content("Great!")
    expect(page).to have_content("49.99")
    expect(page).to have_content("The Ritz Flat")
    expect(page).to have_content("Snazzy!")
    expect(page).to have_content("89.99")
    expect(page).to have_content("Test User")
    expect(page).to have_content("test@user.com")
  end
end
