require 'rubygems'
require 'bundler/setup'

if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start do
    add_filter do |src|
      src.filename !~ /#{File.join(root, 'lib')}\//
    end
  end
end

require 'wordpress-client'

RSpec.configure do |config|
  config.mock_with :rspec

  config.before :each do
    Wordpress.logger = Logger.new("/dev/null") 
  end
end

