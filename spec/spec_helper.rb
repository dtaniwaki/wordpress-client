require 'rubygems'
require 'bundler/setup'
require 'coveralls'
Coveralls.wear!

require 'wordpress-client'

RSpec.configure do |config|
  config.mock_with :rspec

  config.before :each do
    Wordpress.logger = Logger.new("/dev/null") 
  end
end

