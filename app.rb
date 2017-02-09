require 'json'
require 'sinatra'

class SimonApp < Sinatra::Base

  configure do
    configs = {}

    Dir['config/*.json'].each do |file_name|
      config = JSON.parse(File.read(file_name))
      config_name = config['name']

      get "/#{config_name}" do
        '<html><body><h1>Foo</h1></body></html>'
      end

      configs[config['name']] = config
    end

    set :configs, configs
  end

  get '/' do
    haml :index, :locals => {sources: settings.configs.keys}
  end

end
