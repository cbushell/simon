class ServiceTest

  def initialize(config)
    @config = config
  end

  def test_services
    @config['sources'].collect do |source|
      url = source['url']
      method = source['method']

      {url: url, responseCode: HTTParty.get(url).response.code}
    end
  end

end