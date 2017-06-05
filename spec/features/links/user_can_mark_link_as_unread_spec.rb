require 'rails_helper'

describe 'user can mark link as unread', :js => :true do
  xit 'for a read link' do
    current_user = User.create!(email: 'example@email.com', password: 'password')
    link = current_user.links.create!(title: 'my first link', url: 'https://news.ycombinator.com/', read: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    visit root_path

    within('.links') do
      expect(page).to have_content('Read')
      expect(page).to have_button('Mark as Unread')
    end

    expect(link.read).to eq(true)

    within('.links') do
      click_button 'Mark as Unread'
    end

    within('.links .read-status') do
      expect(page).to have_content('Unread')
    end

    within('.links button') do
      expect(page).to have_link('Mark as Read')
    end

    expect(link.read).to eq(false)
  end
end
