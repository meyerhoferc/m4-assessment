require 'rails_helper'

describe 'a user filters links', :js => :true do
  xit 'can filter by read links' do
    current_user = User.create!(email: 'example@email.com', password: 'password')
    current_user.links.create!(title: 'y combinator', url: 'https://news.ycombinator.com/', read: false)
    current_user.links.create!(title: 'turing', url: 'http://turing.io', read: true)
    current_user.links.create!(title: 'my site', url: 'http://legislate.money', read: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    visit root_path

    within('.links') do
      expect(page).to have_content('turing')
      expect(page).to have_content('y combinator')
      expect(page).to have_content('my site')
      expect(page).to have_content('http://turing.io')
      expect(page).to have_content('http://legislate.money')
      expect(page).to have_content('https://news.ycombinator.com/')
    end

    click_on 'Show Read'

    within('.links') do
      expect(page).to_not have_content('turing')
      expect(page).to have_content('y combinator')
      expect(page).to have_content('my site')
      expect(page).to_not have_content('http://turing.io')
      expect(page).to have_content('http://legislate.money')
      expect(page).to have_content('https://news.ycombinator.com/')
    end
  end

  xit 'can filter by unread links' do
    current_user = User.create!(email: 'example@email.com', password: 'password')
    current_user.links.create!(title: 'y combinator', url: 'https://news.ycombinator.com/', read: false)
    current_user.links.create!(title: 'turing', url: 'http://turing.io', read: true)
    current_user.links.create!(title: 'my site', url: 'http://legislate.money', read: true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    visit root_path

    within('.links') do
      expect(page).to have_content('turing')
      expect(page).to have_content('y combinator')
      expect(page).to have_content('my site')
      expect(page).to have_content('http://turing.io')
      expect(page).to have_content('http://legislate.money')
      expect(page).to have_content('https://news.ycombinator.com/')
    end

    click_on 'Show Unread'

    within('.links') do
      expect(page).to have_content('turing')
      expect(page).to_not have_content('y combinator')
      expect(page).to_not have_content('my site')
      expect(page).to have_content('http://turing.io')
      expect(page).to_not have_content('http://legislate.money')
      expect(page).to_not have_content('https://news.ycombinator.com/')
    end
  end

  describe 'filter case insensitively through a search bar' do
    xit 'can filter links by title or url' do
      current_user = User.create!(email: 'example@email.com', password: 'password')
      current_user.links.create!(title: 'my first link', url: 'https://news.ycombinator.com/', read: false)
      current_user.links.create!(title: 'my second link', url: 'http://turing.io', read: true)
      current_user.links.create!(title: 'my third link', url: 'http://legislate.money', read: true)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
      visit root_path

      fill_in('search', with: 'my')

      within('.links') do
        expect(page).to have_content('my first link')
        expect(page).to have_content('my second link')
        expect(page).to have_content('my third link')
        expect(page).to have_content('http://turing.io')
        expect(page).to have_content('http://legislate.money')
        expect(page).to have_content('https://news.ycombinator.com/')
      end

      fill_in('search', with: 'MY fI')

      within('.links') do
        expect(page).to have_content('my first link')
        expect(page).to_not have_content('my second link')
        expect(page).to_not have_content('my third link')
        expect(page).to_not have_content('http://turing.io')
        expect(page).to_not have_content('http://legislate.money')
        expect(page).to have_content('https://news.ycombinator.com/')
      end
    end
  end
end
