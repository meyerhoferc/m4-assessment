require 'rails_helper'

describe HotreadsService, type: :model do
  describe '#top_ten' do
    it 'gets the current top ten reads from the HotReads service' do
      VCR.use_cassette('hotreads-service/top-ten') do
        service = HotreadsService.new
        top_ten = service.top_ten
        expect(top_ten).to be_truthy
        expect(top_ten[0]['url']).to eq('http://github.com')
      end
    end
  end
end
