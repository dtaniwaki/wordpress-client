require 'wordpress/errors'
require 'wordpress/request'
Dir.glob(File.expand_path('../api/*.rb', __FILE__)) do |path|
  require path
end

module Wordpress
  module API
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend(ClassMethods)
      base.class_eval do
        include Posts
        include Comments
        include Sites
        include Me
        include Tests
        include Follow
        include Taxonomy
        include Notifications
        include FreshlyPressed
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def exec_api(request, &response)
        json = call(request, :bearer_token_request => true)

        if !json['error'].nil?
          raise Wordpress::ResponseError, json
        end
      
        if response.nil?
          Wordpress::OpenStruct.new(json)
        else
          instance_exec(json, &response)
        end
      end

      private

      def validate_keys!(params, valid_keys)
        params.keys.each do |key|
          raise Wordpress::ArgumentError, "#{key} is not valid for this method." unless valid_keys.include?(key)
        end
      end

      def default_keys
        [:http_envelope, :pretty, :meta, :callback].freeze
      end
  
      def search_keys
        [:number, :offset, :page, :order, :order_by, :after, :before].freeze
      end
    end
  end
end
