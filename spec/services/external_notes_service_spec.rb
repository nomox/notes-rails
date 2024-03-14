require 'rails_helper'

RSpec.describe ExternalNotesService do
  let(:http_client) { instance_double(HttpClient) }
  let(:service) { described_class.new(http_client) }

  describe '#call' do
    let(:response_data) { [{ title: 'Note 1', content: 'Content 1' }] }

    context 'when the request is successful' do
      before do
        allow(http_client).to receive(:get).and_return(status: 200, body: response_data)
      end

      it 'returns the response body' do
        expect(service.call).to eq(response_data)
      end
    end

    context 'when the request fails' do
      before do
        allow(http_client).to receive(:get).and_return(status: 404, body: nil)
      end

      it 'returns an empty array' do
        expect(service.call).to eq([])
      end
    end
  end
end
