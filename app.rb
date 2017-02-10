require 'json'
require 'sinatra'
require 'httparty'
require_relative 'lib/simon_config'
require_relative 'lib/service_test'

class SimonApp < Sinatra::Base

  configure do
    set :config, SimonConfig.new('config')
  end

  get '/' do
    haml :index, :locals => {sources: settings.config.config_names}
  end

  get '/:config_name_as_url' do
    config = settings.config.config_for(params[:config_name_as_url])
    haml :status, :locals => {config: config}
  end

  get '/:config_name_as_url/test' do
    content_type :json

    config = settings.config.config_for(params[:config_name_as_url])
    ServiceTest.new(config).test_services.to_json
  end

end
