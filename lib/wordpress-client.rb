require 'logger'
require 'wordpress/client'

module Wordpress
  class << self
    def client
      @client ||= Wordpress::Client.new
    end

    def client?
      !!@client
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end
