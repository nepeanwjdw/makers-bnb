require 'sinatra/base'
require 'sinatra/flash'
require './DatabaseConnection_setup'
require_relative './lib/Space'
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
    redirect('/view_all_spaces')
  end

  get '/sign_in' do
    erb(:sign_in)
  end

  post '/sign_in' do
    User.fetch(email: params[:email], password: params[:password])
    redirect('/view_all_spaces')
  end

  get '/create-space' do
    erb(:create_space)
  end

  get '/view_all_spaces' do
    @spaces = Space.all
    erb(:view_all_spaces)
  end
end
