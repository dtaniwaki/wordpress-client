require 'wordpress/base'

module Wordpress
  class OpenStruct < Wordpress::Base
    def_delegators :@hash, :map, :each

    def initialize(hash = {})
      @hash = Hash[hash.map do |key, value|
        key = key.to_s
        unless respond_to?(key)
          metaclass.send(:define_method, key, Proc.new do
            v = @hash[key]
            @hash[key] = (v.is_a?(Hash) ? Wordpress::OpenStruct.new(v) : v)
          end)
        end
        unless respond_to?("#{key}=")
          metaclass.send(:define_method, "#{key}=", Proc.new do |v|
            @hash[key] = (v.is_a?(Hash) ? Wordpress::OpenStruct.new(v) : v)
            @hash[key]
          end)
        end
        [key, (value.is_a?(Hash) ? Wordpress::OpenStruct.new(value) : value)]
      end]
    end

=begin
    def respond_to_missing?(method_name, include_private = false)
      method_name = method_name.to_s
      @hash.include?(method_name) || super
    end
=end
    def to_s
      "#<#{self.class.name} #{map { |k, v| "#{k}=#{v}" }.join(" ")}>"
    end

    def [](k)
      send(k)
    end

    def []=(k, v)
      send("#{k}=", v)
    end

    private
=begin
    def method_missing(method_name, *args, &block)
      key = method_name.to_s
      if key[-1] == '='
        key = key[0..-2]
        if @hash.include?(key)
          v = args[0]
          return @hash[key] = (v.is_a?(Hash) ? Wordpress::OpenStruct.new(v) : v)
        end
      else
        v = @hash[key]
        return @hash[key] = (v.is_a?(Hash) ? Wordpress::OpenStruct.new(v) : v)
      end
      super
    end
=end
  end
end
