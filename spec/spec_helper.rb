require 'rubygems'
require 'bundler/setup'

require 'wordpress-client'

RSpec.configure do |config|

end

require 'simplecov'
SimpleCov.start do
  add_group 'lib', 'lib'
end if ENV["COVERAGE"]
