require 'rails_helper'

RSpec.describe Link, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
  end

  describe '#is_valid?' do
    it 'validates a url' do
      link_one = Link.new(title: 'turing', url: 'turing.io')
      link_two = Link.new(title: 'turing', url: 'http://turing.io')
      expect(Link.is_valid?(link_one.url)).to_not be_truthy
      expect(Link.is_valid?(link_two.url)).to be_truthy
    end
  end
end
