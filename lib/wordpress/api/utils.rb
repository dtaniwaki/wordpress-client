require 'multi_json'
require 'wordpress/errors'
require 'wordpress/ostruct'
Dir.glob(File.expand_path('../../object/*.rb', __FILE__)) do |path|
 require path
end

module Wordpress
  module API
    module Utils
      def object_from_response(obj, request)
        res = call(request, :bearer_token_request => true)
        begin
          json = MultiJson.load(res)
          if json.nil? || json == ''
            raise Wordpress::ResponseError
          end
          if !json['error'].nil?
            raise Wordpress::ResponseError, json
          end
          obj.assign(json)
        rescue MultiJson::LoadError => e
          raise Wordpress::ResponseError, {'error' => e, 'message' => "Can not parse the response: #{res.inspect}"}
        end
      end

      private

      def default_keys
        [:http_envelope, :pretty, :callback]
      end

      def search_keys
        [:number, :offset, :page, :order, :order_by, :after, :before]
      end

      def validate_params!(params, valid_keys = [])
        params.keys.each do |key|
          raise Wordpress::ArgumentError, "#{key} is not valid for this method." unless valid_keys.include?(key)
        end
      end
    end
  end
end
