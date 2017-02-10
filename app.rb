require 'json'
require 'sinatra'
require 'httparty'
require_relative 'lib/configs'
require_relative 'lib/service_test'

class SimonApp < Sinatra::Base

  configure do
    set :configs, Configs.new('config')
  end

  get '/' do
    haml :index, :locals => {sources: settings.configs.config_names}
  end

  get '/:config_name_as_url' do
    config = settings.configs.config_for(params[:config_name_as_url])
    haml :status, :locals => {config: config}
  end

  get '/:config_name_as_url/test' do
    content_type :json

    config = settings.configs.config_for(params[:config_name_as_url])
    ServiceTest.new(config).test_services.to_json
  end

end
