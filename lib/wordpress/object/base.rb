require 'date'
require 'wordpress/base'
require 'wordpress/request'
require 'wordpress/ostruct'

module Wordpress::Object
  class Base < Wordpress::Base
    attr_reader :client, :request

    class << self
      def options
        @options ||= {}
      end

      private

      def attr_parameter(*args)
        opt = args[-1].is_a?(Hash) ? args.pop : {}
        args.each do |arg|
          options[arg.to_s] = opt.dup
        end
      end
    end

    def initialize(client = Wordpress.client, response = {})
      @client = client
      assign(response)
    end

    def assign(response)
      @response = Hash[response.map{ |k, v| [k.to_s.downcase, v] }]
      self
    end

    def [](name)
      name = name.to_s
      get_object(name) if available_object?(name)
    end

    def to_hash
      @response.dup
    end

    def respond_to_missing?(method_name, include_private = false)
      name = method_name.to_s
      is_setter = name.to_s[-1] == '=' ? !!name.pop : false
      (is_setter && available_object?(name[0..-1])) || available_object?(name) || super
    end

    private

    def method_missing(method_name, *arguments, &block)
      name = method_name.to_s
      is_setter = name.to_s[-1] == '='
      if is_setter
        return set_object(name[0...-1], *arguments) if available_object?(name[0...-1])
      else
        return get_object(name) if available_object?(name)
      end
      super(method_name, *arguments, &block)
    end

    def available_object?(name)
      name = name.to_s
      options.include?(name)
    end

    def get_object(name)
      name = name.to_s
      v = @response[name]
      if options && options[name] && (as = options[name][:as])
        if as.is_a?(Proc)
          as.call(client, v)
        elsif as.is_a?(String)
          Wordpress::Object.const_get(as).new(client, v)
        else
          as.new(v)
        end
      elsif v.is_a?(Hash)
        Wordpress::OpenStruct.new(v)
      else
        v
      end
    end

    def set_object(name, v)
      @response[name] = v
    end

    def options
      self.class.options.freeze
    end
  end
end
