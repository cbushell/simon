require 'json'
require 'sinatra'
require 'httparty'
require_relative 'lib/service_test'

class SimonApp < Sinatra::Base

  configure do
    config_filename = ENV['SIMON_CONFIG'] || 'config/news.json'
    
    set :config, JSON.parse(File.read(config_filename))
  end

  get '/' do
    haml :index, :locals => {config: settings.config}
  end

  get '/test' do
    content_type :json
    ServiceTest.new(settings.config).test_services.to_json
  end

end
