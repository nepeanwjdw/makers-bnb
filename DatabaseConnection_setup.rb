require './lib/DatabaseConnection'

db = ENV['RACK_ENV'] == 'test' ? 'makersbnb_test' : 'makersbnb'
DatabaseConnection.setup(db)
