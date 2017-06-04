require 'rails_helper'

describe 'user can mark link as read' do
  it 'for an unread link' do
    current_user = User.create!(email: 'example@email.com', password: 'password')
    link = current_user.links.create!(title: 'my first link', url: 'https://news.ycombinator.com/', read: false)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    visit root_path

    within('.links') do
      expect(page).to have_content('Unread')
      expect(page).to have_link('Mark as Read')
    end

    within('.links') do
      click 'Mark as Read'
    end

    within('.links') do
      expect(page).to have_content('Read')
      expect(page).to have_link('Mark as Unread')
    end
  end
end
