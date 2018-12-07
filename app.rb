require 'sinatra/base'
require 'sinatra/flash'
require_relative './lib/spaces'
require_relative './lib/users'
require_relative './lib/Booking'
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
      user_id: session[:user_id],
      image: params[:image]
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

  get '/:id/request_space' do
    space_id = params[:id]
    @space_info = Space.get_space_info(space_id: space_id)
    @space = Space.new(
      space_id: @space_info['space_id'], name: @space_info['spacename'],
      description: @space_info['description'], price: @space_info['price'],
      user_id: @space_info['user_id']
    )
    @available_dates = Space.get_available_dates(space_id: @space.space_id)
    erb(:request_space)
  end

  post '/:id/request_space' do
    booker_user_id = session[:user_id]
    space_id = params[:id]
    @space_info = Space.get_space_info(space_id: space_id)
    booking_start_date = params[:booking_start_date].split('/').reverse.join('/')
    p booking_start_date
    booking = Booking.create_booking_request(booker_user_id: booker_user_id, space_id: space_id, booking_start_date: booking_start_date)
    if booking == nil
      flash[:notice] = 'Request unsuccessful'
      redirect '/:id/request_space'
    else
      flash[:notice] = "Booking request sent to #{@space_info['username']}"
      redirect '/view_all_spaces'
    end
  end

  get '/sign_out' do
    session.clear
    flash[:notice] = 'You have signed out'
    redirect '/'
  end

  get '/view_all_spaces' do
    @spaces = Space.all
    erb(:view_all_spaces)
  end

  get '/host_dashboard' do
    @incoming_requests = Booking.view_incoming(host_user_id: session[:user_id])
    @logged_in_user = User.retrieve(user_id: session[:user_id])
    @spaces = Space.allFromHost(user_id: session[:user_id])
    erb(:host_dashboard)
  end

  post '/edit_user_details' do
    User.update_name_email(
      user_id: session[:user_id],
      new_name: params[:user_name],
      new_email: params[:user_email]
    )
    flash[:notice] = "Details Updated!"
    redirect('/host_dashboard')
  end

  post '/:id/accept_request' do
    Booking.confirm_booking(booking_id: params[:id], booker_id:, host_id:)
    flash[:notice] = "Booking Request Accepted!"
    redirect('/host_dashboard')
  end

  post '/:id/reject_request' do
    Booking.reject_booking(booking_id: params[:id], booker_id:)
    flash[:notice] = "Booking Request Rejected"
    redirect('/host_dashboard')
  end

  run! if app_file == $0
end
