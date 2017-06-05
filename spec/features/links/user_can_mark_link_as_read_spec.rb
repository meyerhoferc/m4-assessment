require 'rails_helper'

describe 'user can mark link as read', :js => :true do
  it 'for an unread link' do
    current_user = User.create!(email: 'example@email.com', password: 'password')
    link = current_user.links.create!(title: 'my first link', url: 'https://news.ycombinator.com/', read: false)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    visit root_path
    # save_and_open_page
    within('.links') do
      expect(page).to have_content('Unread')
      expect(page).to have_button('Mark as Read')
    end

    expect(link.read).to eq(false)

    within('.links') do
      click_on 'Mark as Read'
    end

    within('.links') do
      expect(page).to have_content('Read')
      expect(page).to have_link('Mark as Unread')
    end

    expect(link.read).to eq(true)
  end
end
