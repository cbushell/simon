require 'json'
require 'sinatra'
require 'httparty'

class SimonApp < Sinatra::Base

  configure do
    configs = {}

    Dir['config/*.json'].each do |file_name|
      config = JSON.parse(File.read(file_name))
      configs[config['name'].downcase.gsub(/\s/, '')] = config
    end

    set :configs, configs
  end

  get '/' do
    haml :index, :locals => {sources: settings.configs.keys}
  end

  get '/:config_name' do
    haml :status, :locals => {config_name: params[:config_name],
                              sources: settings.configs[config_name_as_url(params[:config_name])]['sources'].collect { |s| s['url'] }}
  end

  get '/:config_name/test' do
    content_type :json

    settings.configs[params[:config_name]]['sources'].collect do |source|
      url = source['url']
      method = source['method']

      {url: url, responseCode: HTTParty.get(url).response.code}
    end.to_json
  end

  helpers do
    def config_name_as_url(config_name)
      config_name.downcase.gsub(/\s/, '')
    end
  end

end
