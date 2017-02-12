require 'json'
require 'sinatra'
require 'httparty'
require_relative 'lib/service_tester'

class SimonApp < Sinatra::Base

  configure do
    config_filename = ENV['SIMON_CONFIG'] || 'config/news.json'

    config = JSON.parse(File.read(config_filename))
    service_tester = ServiceTester.new(config)

    set :config, config
    set :service_tester, service_tester
  end

  get '/' do
    haml :index, :locals => {config: settings.config}
  end

  get '/test' do
    content_type :json
    settings.service_tester.test_services.to_json
  end

end
