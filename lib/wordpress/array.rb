require 'wordpress/object'

module Wordpress
  class Array < Wordpress::Object
    def_delegators :@posts, :method_missing, :respond_to_missing?
    class << self
      def array_delegator(name)
        class_eval <<-EOS
          private

          def array_delegator
            #{name}
          end
        EOS
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      array_delegator.respod_to?(method_name, include_private)
    end

    def method_missing(method_name, *arguments, &block)
      if array_delegator.respond_to?(method_name)
        array_delegator.send(method_name, *arguments, &block)
      else
        super
      end
    end
  end
end
