require 'json'
require 'sinatra'

class SimonApp < Sinatra::Base

  configure do
    url_paths = []

    Dir['config/*.json'].each do |file_name|
      json = JSON.parse(File.read(file_name))

      url_path = file_name.gsub(/^config\//, '').gsub(/\.json$/, '')
      url_paths << url_path

      get "/#{url_path}" do
        '<html><body><h1>Foo</h1></body></html>'
      end
    end

    set :url_paths, url_paths
  end

  get '/' do
    haml :index, :locals => {url_paths: settings.url_paths}
  end

end
