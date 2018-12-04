require 'sinatra/base'
require 'sinatra/flash'
require './DatabaseConnection_setup'
require_relative './lib/Users'
require_relative './lib/Space'

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

    get '/sign_in' do
    erb(:sign_in)
  end

  post '/sign_in' do
    User.fetch(email: params[:email], password: params[:password])
    redirect('/')
  end

  get '/create_space' do
    erb(:create_space)
  end

  post '/create_space' do
    # Space.create(name: params[:name], description: params[:description], price: params[:price], user_id: 1)
    p params[:daterange]
    redirect('/create_space')
  end
end
