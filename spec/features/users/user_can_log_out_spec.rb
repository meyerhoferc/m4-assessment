require 'rails_helper'

describe 'user log out' do
  it 'from the root page' do
    User.create!(email: 'email@email.com', password: 'password')
    visit root_path
    expect(current_path).to eq(authenticate_path)

    click_on 'Log In'

    expect(current_path).to eq(login_path)

    fill_in('session[email]', with: 'email@email.com')
    fill_in('session[password]', with: 'password')
    click_on 'Log In'

    expect(page).to have_link('Logout')
    expect(page).to_not have_link('Log In')

    click_on 'Logout'

    expect(current_path).to eq(root_path)
  end
end
