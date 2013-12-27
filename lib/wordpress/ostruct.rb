require 'wordpress/base'

module Wordpress
  class OpenStruct < Base
    def_delegators :@hash, :map, :each, :any?, :all?, :size

    def initialize(hash = {})
      assign(hash)
    end

    def assign(hash = {})
      @hash = Hash[hash.map{ |k, v| [k.to_s, v] }]
      self
    end

    def respond_to_missing?(method_name, include_private = false)
      key = method_name.to_s
      if @hash.include?(key)
        define_accessor(key)
      else
        super
      end
    end

    def to_s
      "#<#{self.class.name} #{@hash.keys.map{ |k| "#{k}=#{send(k).to_s}" }.join(" ")}>"
    end

    def [](k)
      send(k.to_s)
    end

    def []=(k, v)
      send("#{k}=", v)
    end

    def to_hash
      @hash
    end

    private

    def method_missing(method_name, *args, &block)
      key = method_name.to_s
      key = key[-1] == '=' ? key[0...-1] : key
      if @hash.include?(key)
        define_accessor(key)
        send(method_name, *args, &block)
      else
        super
      end
    end

    def define_accessor(key)
      metaclass.send(:define_method, key, Proc.new{
        v = @hash[key]
        v.is_a?(Hash) ? Wordpress::OpenStruct.new(v) : v
      })
      metaclass.send(:define_method, "#{key}=", Proc.new{ |v|
        @hash[key] = v
      })
    end
  end
end
