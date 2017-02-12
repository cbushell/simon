class ServiceTest

  def initialize(config)
    @config = config
  end

  def test_services
    @config['sources'].collect do |source|
      url = source['url']
      method = source['method']

      startTime = Time.now
      response = HTTParty.get(url).response
      
      {url: url,
       responseCode: response.code,
       responseTime: Time.now - startTime}
    end
  end

end