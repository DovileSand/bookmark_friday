feature 'user signs up' do

  before(:each) do
    visit ('/')
      fill_in('username', with: 'Dovile')
      fill_in('email', with: 'test@test.com')
      fill_in('password', with: '1234')
  end

  scenario 'displaying welcome message after user signs up' do

      click_button('Sign Up')
      expect(page).to have_content('Welcome Dovile')
  end

  scenario 'adds the user to the database' do

      user_count_before = User.count
      click_button('Sign Up')
      user_count_after = User.count
      expect(user_count_after).to eq(user_count_before + 1)
  end

  scenario 'returning correct email address' do

    click_button('Sign Up')
    user = User.first(username: 'Dovile')
    expect(user.email).to eq('test@test.com')

  end

end
