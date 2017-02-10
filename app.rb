require 'json'
require 'sinatra'
require 'httparty'
require_relative 'lib/configs'

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

  get '/:config_name/test' do
    content_type :json

    settings.configs.config_for(params[:config_name])['sources'].collect do |source|
      url = source['url']
      method = source['method']

      {url: url, responseCode: HTTParty.get(url).response.code}
    end.to_json
  end

end
