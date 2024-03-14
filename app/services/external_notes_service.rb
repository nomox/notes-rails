class ExternalNotesService
  attr_reader :http_client

  def initialize(http_client)
    @http_client = http_client
  end

  def self.call(*args, **kwargs)
    new(*args, **kwargs).call
  end

  def call
    response = http_client.get('http://localhost:3000/notest_external_api.json')
    return [] if response[:status] >= 400

    response[:body]
  end
end
