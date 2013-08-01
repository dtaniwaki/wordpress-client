require 'json'
require 'wordpress/errors'
require 'wordpress/ostruct'
require 'wordpress/user'
require 'wordpress/site'
require 'wordpress/post'
require 'wordpress/post_array'
require 'wordpress/like_array'
require 'wordpress/comment'
require 'wordpress/test'

module Wordpress
  module API
    module Utils
      private

      def object_from_response(klass, path, method, params = {})
        res = request(method, "/rest/v1#{path}", params, :bearer_token_request => true)
        if res
          json = MultiJson.load(res)
          if json.nil? || json == ''
            raise Wordpress::ResponseError
          end
          if !json['error'].nil?
            raise Wordpress::ResponseError, json['message']
          end
          klass.new(json)
        end
      end

      def validate_params!(params, valid_keys = [], type = nil)
        valid_keys += [:http_envelope, :pretty, :callback] if type != :test
        valid_keys += [:number, :offset, :page, :order, :order_by, :after, :before] if type == :search
        params.keys.each do |key|
          raise RuntimeError, "#{key} is not valid for this method." unless valid_keys.include?(key)
        end
      end
    end
  end
end
