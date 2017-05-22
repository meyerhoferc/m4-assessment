require 'rails_helper'

describe 'user can edit link' do
  it 'from the root_path' do
    current_user = User.create!(email: 'example@email.com', password: 'password')
    link = current_user.links.create!(title: 'my first link', url: 'https://news.ycombinator.com/', read: false)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    visit root_path

    within('.links') do
      click_on 'Edit'
    end

    expect(current_path).to eq(edit_link_path(link))

    fill_in('link[title]', with: 'YCombinator')
    click_on 'Update Link'

    within('.success') do
      expect(page).to have_content('Link updated.')
    end

    expect(current_path).to eq(root_path)

    within('.links') do
      expect(page).to have_content('YCombinator')
      expect(page).to_not have_content('my first link')
    end
  end
end
