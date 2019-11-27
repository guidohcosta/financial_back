class LegacyService
  LEGACY_SERVICE_URL = 'http://localhost:3002/transfers'

  def self.transfer(params)
    response = RestClient.post(LEGACY_SERVICE_URL, params)
    JSON.parse(response.body)
  end
end
