require 'rubygems'
require 'bundler/setup'

require 'wordpress-client'

RSpec.configure do |config|
  config.mock_with :rspec

  config.before :each do
    Wordpress.logger = Logger.new("/dev/null") 
  end
end

require 'simplecov'
SimpleCov.start do
  add_group 'lib', 'lib'
end if ENV["COVERAGE"]
