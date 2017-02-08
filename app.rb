require 'sinatra'

class SimonApp < Sinatra::Base
  get '/' do
    "<html><body>Foo</body></html>"
  end
end
