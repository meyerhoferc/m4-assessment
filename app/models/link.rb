require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user
  validates :url, :title, presence: true

  def self.is_valid?(uri)
    parsed_uri = URI.parse(uri)
    parsed_uri.class == URI::HTTP && parsed_uri.host && !parsed_uri.host.nil?
  end
end
