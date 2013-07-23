require 'wordpress/base'
require 'date'

module Wordpress
  class Object < Wordpress::OpenStruct
    class << self
      def attr_parameter(*args)
        options = args[-1].is_a?(Hash) ? args.pop : {}
        args.each do |arg|
          arg = arg.to_s

          define_method arg do
            send("#{arg}=", @hash[arg])
          end

          define_method "#{arg}=" do |v|
            if as = options[:as]
              @hash[arg] = (as.is_a?(Proc) ? as.call(v) : as.new(v))
            elsif v.is_a?(Hash)
              @hash[arg] = Wordpress::OpenStruct.new(v)
            else
              @hash[arg] = v
            end
            @hash[arg]
          end
        end
      end
    end

    def initialize(params = {})
      params ? super(Hash[params.map { |k, v| [k.to_s.downcase, v] }]) : super
    end
  end
end
