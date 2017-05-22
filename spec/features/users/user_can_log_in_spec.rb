require 'rails_helper'

describe 'user log in' do
  it 'can log in with invalid credentials' do
    User.create!(email: 'email@email.com', password: 'password')
    visit root_path
    expect(current_path).to eq(authenticate_path)

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    fill_in('session[email]', with: 'email@email.com')
    fill_in('session[password]', with: 'password')
    click_on 'Log In'

    within('.success') do
      expect(page).to have_content('Successfully logged in as email@email.com')
    end
  end

  it 'cannot login with invalid credentials' do
    User.create!(email: 'email@email.com', password: 'password')
    visit login_path

    fill_in('session[email]', with: 'email@email.com')
    fill_in('session[password]', with: 'other-password')
    click_on 'Log In'

    within('.danger') do
      expect(page).to have_content('Invalid login credentials')
    end

    fill_in('session[email]', with: 'other-email@email.com')
    fill_in('session[password]', with: 'password')
    click_on 'Log In'

    within('.danger') do
      expect(page).to have_content('Invalid login credentials')
    end
  end
end
