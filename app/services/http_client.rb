class HttpClient
  def get(url)
    response = Net::HTTP.get_response(URI(url))
    body = response.body.empty? ? nil : JSON.parse(response.body)

    {
      status: response.code.to_i,
      body: body
    }
  end
end
