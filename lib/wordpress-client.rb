require 'logger'
require 'wordpress/version'
require 'wordpress/client'

module Wordpress
  class << self
    attr_writer :logger

    def client
      @client ||= Wordpress::Client.new
    end

    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end
