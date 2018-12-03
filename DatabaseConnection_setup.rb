require './lib/DatabaseConnection'

db = ENV['RACK_ENV'] == 'test' ? 'makers_bnb_test' : 'makers_bnb'
DatabaseConnection.setup(db)
