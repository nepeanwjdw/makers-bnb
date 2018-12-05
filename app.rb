require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/spaces'
require_relative './lib/users'
require_relative './database_connection_setup'

# top level comment
class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb(:index)
  end

  get '/sign_up' do
    erb(:sign_up)
  end

  post '/sign_up' do
    user = User.create(
      name: params[:name],
      email: params[:email],
      password: params[:password]
    )
    session[:user_id] = user.user_id
    redirect('/view_all_spaces')
  end

  get '/sign_in' do
    erb(:sign_in)
  end

  post '/sign_in' do
    user = User.authenticate(
      email: params[:email],
      password: params[:password]
    )
    if user
      session[:user_id] = user.user_id
      redirect('/view_all_spaces')
    else
      flash[:notice] = 'Login details incorrect, try again!'
      redirect('/sign_in')
    end
  end

  get '/create_space' do
    erb(:create_space)
  end

  post '/create_space' do
    space = Space.create(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      user_id: session[:user_id]
    )
    dates = params[:daterange].split(' - ')
    start_date = dates.first.split('/').reverse.join('/')
    end_date = dates.last.split('/').reverse.join('/')
    Space.create_availability(
      space_id: space.space_id,
      start_date: start_date,
      end_date: end_date
    )
    redirect('/view_all_spaces')
  end

  get '/view_all_spaces' do
    @spaces = Space.all
    erb(:view_all_spaces)
  end

  get '/host_dashboard' do
    @spaces = Space.all
    erb(:host_dashboard)
  end

  run! if app_file == $0
end
