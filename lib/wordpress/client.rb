require 'wordpress/base'
require 'wordpress/request'
require 'wordpress/api'
require 'faraday'
require 'faraday_middleware/gzip'
require 'multi_json'

module Wordpress
  class Client < Base
    include Wordpress::API

    attr_accessor :access_token

    def initialize
      @conn = Faraday.new do |faraday|
        faraday.use Faraday::Response::Logger, logger
        faraday.request :url_encoded
        faraday.response :gzip
        faraday.adapter Faraday.default_adapter
      end
    end

    def call(request, options = {})
      debug "Request: #{request}"

      response = @conn.send(request.method) do |req|
        req.url request.url
        req.params = request.params
        req.body = request.body.to_s
        if options.delete(:bearer_token_request) && !access_token.nil?
          req.headers['Authorization'] = bearer_auth_header
        end
        req.headers['Accept-Encoding'] = 'gzip,deflate'
        req.headers['Content-Type'] = 'application/json'
        req.options[:timeout] = 10
        req.options[:open_timeout] = 5
      end

      debug "Response: #{response.body}"

      response.body
    end

    private

    def bearer_auth_header
      "Bearer #{access_token}"
    end
  end
end
