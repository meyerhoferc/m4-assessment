class HotreadsService
  def initialize
    @base_url = 'https://desolate-crag-20501.herokuapp.com/'
  end

  def top_ten
    links = HTTParty.get(@base_url + '/api/v1/links')
    JSON.parse(links.body)
  end
end
