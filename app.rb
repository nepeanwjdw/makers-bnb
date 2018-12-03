require 'sinatra/base'
require 'sinatra/flash'
require './DatabaseConnection_setup'

class MakersBNBApp < Sinatra::Base
  run! if app_file == $0

  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb(:index)
  end

end
