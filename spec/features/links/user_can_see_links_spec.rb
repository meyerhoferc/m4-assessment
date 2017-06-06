require 'rails_helper'

describe 'a user visits the root path' do
  xit 'they can only see their own links' do
    user = User.create!(email: 'email@email.com', password: 'password')
    user.links.create!(title: 'other user link', url: 'http://google.com')
    user.links.create!(title: 'tacos are good', url: 'http://taco.com')

    current_user = User.create!(email: 'example@email.com', password: 'password')
    current_user.links.create!(title: 'my first link', url: 'https://news.ycombinator.com/')
    current_user.links.create!(title: 'my second link', url: 'http://kaggle.com')

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)

    visit root_path

    within('.links') do
      expect(page).to_not have_content('other user link')
      expect(page).to_not have_content('tacos are good')
      expect(page).to_not have_link('http://google.com')
      expect(page).to_not have_link('http://taco.com')

      expect(page).to have_content('my first link')
      expect(page).to have_content('my second link')
      expect(page).to have_link('https://news.ycombinator.com/')
      expect(page).to have_link('http://kaggle.com')
    end
  end

  it 'they see hot links also' do
    VCR.use_cassette('links/view-all') do
      user = User.create!(email: 'email@email.com', password: 'password')
      github_link = user.links.create!(title: 'github', url: 'http://github.com')
      taco_link = user.links.create!(title: 'tacos are good', url: 'http://taco.com')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      within("#link-#{github_link.id}") do
        expect(page).to have_content('so hot right now')
      end

      within("#link-#{taco_link.id}") do
        expect(page).to_not have_content('so hot right now')
      end
    end
  end
end
