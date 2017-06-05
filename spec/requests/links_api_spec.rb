require 'rails_helper'

describe 'Links API' do
  describe 'PATCH /api/v1/links/:id' do
    it 'persists across the database' do
      current_user = User.create!(email: 'example@email.com', password: 'password')
      link = current_user.links.create!(title: 'my first link', url: 'https://news.ycombinator.com/', read: false)
      expect(link.read).to eq(false)
      expect(Link.count).to eq(1)

      patch "/api/v1/links/#{link.id}", {read: true}
      expect(response).to be_success
      expect(Link.count).to eq(1)

      link_json = JSON.parse(response.body)
      expect(link_json["title"]).to eq('my first link')
      expect(link_json["url"]).to eq('https://news.ycombinator.com/')
      expect(link_json["read"]).to eq(true)
    end
  end
end
