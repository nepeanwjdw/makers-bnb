require 'sinatra/base'
require 'sinatra/flash'
require './DatabaseConnection_setup'
require_relative './lib/Users'

class MakersBNBApp < Sinatra::Base
  run! if app_file == $0

  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb(:index)
  end

  get '/sign_up' do
    erb(:sign_up)
  end

  post '/sign_up' do
    User.create(name: params[:name], email: params[:email], password: params[:password])
    redirect('/')
  end

end
