require 'sinatra'

class SimonApp < Sinatra::Base
  get '/' do
    haml :index
  end
end
