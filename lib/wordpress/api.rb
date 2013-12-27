require 'wordpress/errors'
require 'wordpress/request'

module Wordpress
  module API
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.extend(ClassMethods)
      base.class_eval do
        Dir.glob(File.expand_path('../api/*.rb', __FILE__)) do |path|
          eval(File.open(path).read)
        end
      end
    end

    module ClassMethods
      def register_api(name, method, path, valid_keys, response)
        arg_names = path.scan(/\$([\w]+)/).map{ |a| a[0] }

        @registered_apis ||= {}
        @registered_apis[name] = {:method => method, :path => path, :arg_names => arg_names, :valid_keys => valid_keys, :response => response}

        remove_method name if method_defined?(name)
        define_method name do |*args|
          params = args[-1].is_a?(Hash) ? args.pop : {}

          params.keys.each do |key|
            raise Wordpress::ArgumentError, "#{key} is not valid for this method." unless valid_keys.include?(key)
          end

          path = path.dup
          arg_names.each do |key|
            path.gsub!(/\$#{key}/, args.shift.to_s)
          end
          data = args.shift || {}

          json = call_api(Wordpress::Request.new(method, path, params, data))

          instance_exec(json, &response)
        end
      end
  
      def default_keys
        [:http_envelope, :pretty, :callback].freeze
      end
  
      def search_keys
        [:number, :offset, :page, :order, :order_by, :after, :before].freeze
      end

      def registered_apis
        (@registered_apis || {}).freeze
      end
    end

    module InstanceMethods
      def call_api(request)
        json = call(request, :bearer_token_request => true)

        if !json['error'].nil?
          raise Wordpress::ResponseError, json
        end
      
        json
      end
    end
  end
end
