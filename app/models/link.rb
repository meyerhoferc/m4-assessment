require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user
  validates :url, :title, presence: true

  def self.is_valid?(uri)
    parsed_uri = URI.parse(uri)
    (parsed_uri.class == URI::HTTP || parsed_uri.class == URI::HTTPS) && parsed_uri.host && !parsed_uri.host.nil?
  end

  def self.current_links(current_user)
    links = Link.where(user_id: current_user.id)
    hotreads_service = HotreadsService.new
    hotreads = hotreads_service.top_ten

    hotreads = hotreads.map do |link|
      link["url"]
    end

    hot_links = links.map do |link|
      if link.url.in?(hotreads)
        ['hot', link]
      else
        [nil, link]
      end
    end
  end
end
