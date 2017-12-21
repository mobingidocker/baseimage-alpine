require 'sinatra/base'

class MyApp < Sinatra::Base
  get '/' do
    'Hello Sinatra! ' + ENV['MYENV']
  end
end
