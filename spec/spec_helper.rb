ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', 'app.rb')

require 'capybara'
require 'capybara/rspec'
require 'simplecov'
require 'simplecov-console'
require_relative './setup_test_database'

Capybara.app = MakersBnB

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::Console
  ]
)
SimpleCov.start

RSpec.configure do |config|
  config.before(:each) do
    setup_test_database
  end
end
