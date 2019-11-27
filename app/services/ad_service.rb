class AdService
  AD_SERVICE_URL = 'http://localhost:3001/auth'

  def self.authenticate(username)
    response = RestClient.post(AD_SERVICE_URL, { user: username })
    JSON.parse(response.body)
  end
end
