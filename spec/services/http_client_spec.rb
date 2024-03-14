require 'rails_helper'

RSpec.describe HttpClient do
  describe '#get' do
    let(:http_client) { described_class.new }
    let(:url) { 'http://exampleapi.com/api/v1/data' }
    let(:response_body) { { 'key' => 'value' } }
    let(:status) { '200' }

    before do
      allow(Net::HTTP).to receive(:get_response).with(URI(url))
                                                .and_return(double(code: status, body: response_body.to_json))
    end

    it 'returns the response body and status code' do
      response = http_client.get(url)
      expect(response[:status]).to eq(status.to_i)
      expect(response[:body]).to eq(response_body)
    end
  end
end
