unless Kernel.respond_to?(:require_relative)
  module Kernel
    def require_relative(relative_path)
      desired_path = File.expand_path('../' + relative_path.to_str, caller[0])
      shortest = desired_path
      $:.each do |path|
        path += '/'
        if desired_path.index(path) == 0
          candidate = desired_path.sub(path, '')
          shortest = candidate if candidate.size < shortest.size
        end
      end
      require shortest
    end
  end
end

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

    def configure(&block)
      block.call(configuration)
      configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
