# spec/models/request_log_query_spec.rb
require 'rails_helper'

RSpec.describe RequestLogsQuery do
  let(:request_logs) { double('RequestLog') }

  describe '#call' do
    it 'applies method filter' do
      allow(request_logs).to receive(:where).with(method: 'GET').and_return(request_logs)
      query = RequestLogsQuery.new({ method: 'GET' }, request_logs)
      expect(query.call).to have_received(:where).with(method: 'GET')
    end

    it 'applies response_status filter' do
      allow(request_logs).to receive(:where).with(response_status: 200).and_return(request_logs)
      query = RequestLogsQuery.new({ response_status: 200 }, request_logs)
      expect(query.call).to have_received(:where).with(response_status: 200)
    end

    it 'applies error_class filter' do
      allow(request_logs).to receive(:where).with('error.class_name' => 'SomeError').and_return(request_logs)
      query = RequestLogsQuery.new({ error_class: 'SomeError' }, request_logs)
      expect(query.call).to have_received(:where).with('error.class_name' => 'SomeError')
    end
  end
end
