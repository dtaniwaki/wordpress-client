require 'wordpress/base'
require 'wordpress/api'
require 'curb'

module Wordpress
  class Client < Wordpress::Base
    include Wordpress::API

    attr_accessor :access_token
    attr_accessor :end_point => "https://public-api.wordpress.com/"

    private

    def request(method, path, params = {}, options = {})
      query_params = params[:query] || {}
      request_params = params[:request] || {}
      uri = end_point + (end_point[-1] == '/' ? '' : '/') + path.sub(/^[\/]+/, '')
      uri += "?#{query_params.map{ |k, v| "#{k}=#{v}" }.join('&')}" if !query_params.empty?

      debug <<-EOS
Request Dump
  Method     : #{method}
  Path       : #{uri}
  Parameters : #{request_params.inspect}
      EOS

      http = Curl.send(method, uri, request_params) do |http|
        if options.delete(:bearer_token_request) && !access_token.nil?
          http.headers['Authorization'] = bearer_auth_header
        end
      end
      res = http.body_str
      
      debug <<-EOS
Response Dump
  Content     : #{res}
      EOS

      res
    end

    def bearer_auth_header
      "Bearer #{access_token}"
    end
  end
end
