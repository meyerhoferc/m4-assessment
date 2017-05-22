require 'rails_helper'

describe 'user can link submission' do
  it 'for a valid link' do
    user = User.create!(email: 'email@email.com', password: 'password')
    expect(user.links.count).to eq(0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    fill_in('link[url]', with: 'http://turing.io')
    fill_in('link[title]', with: 'Turing')
    click_on 'Submit URL'

    expect(user.links.count).to eq(1)

    within('.success') do
      expect(page).to have_content('Link successfully added')
    end

    within('.links') do
      expect(page).to have_content('Turing')
      expect(page).to have_link('http://turing.io')
      expect(page).to have_content('Unread')
    end
  end

  it 'for an invalid link' do
    user = User.create!(email: 'email@email.com', password: 'password')
    expect(user.links.count).to eq(0)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    fill_in('link[url]', with: 'turing.io')
    fill_in('link[title]', with: 'Turing')
    click_on 'Submit URL'

    expect(user.links.count).to eq(0)

    within('.danger') do
      expect(page).to have_content('Invalid link')
    end

    within('.links') do
      expect(page).to_not have_content('Turing')
      expect(page).to_not have_link('turing.io')
      expect(page).to_not have_content('Unread')
    end
  end
end
