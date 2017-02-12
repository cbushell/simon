class ServiceTester

  def initialize(config)
    @config = config
    @service_stats = Hash.new { |h, k| h[k] = ServiceStat.new }
  end

  def test_services
    @config['sources'].collect do |source|
      url = source['url']
      method = source['method']

      startTime = Time.now
      response = HTTParty.get(url).response

      @service_stats[url].update_stats(response)

      {url: url,
       responseCode: response.code,
       responseTime: Time.now - startTime}.
          merge(@service_stats[url].stats_hash)

    end
  end

end