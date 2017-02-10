require 'json'
require 'sinatra'
require 'httparty'

class SimonApp < Sinatra::Base

  configure do
    configs = {}

    Dir['config/*.json'].each do |file_name|
      config = JSON.parse(File.read(file_name))
      config_name = config['name']

      get "/#{config_name}" do
        '<html><body><h1>Foo</h1></body></html>'
      end

      get "/:config_name/test" do
        content_type :json

        response = settings.configs[params[:config_name]]['sources'].collect do |source|
          url = source['url']
          method = source['method']

          {url: url, responseCode: HTTParty.get(url).response.code}
        end

        response.to_json
      end

      configs[config['name']] = config
    end

    set :configs, configs
  end

  get '/' do
    haml :index, :locals => {sources: settings.configs.keys}
  end

end
