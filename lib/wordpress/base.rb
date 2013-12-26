module Wordpress
  class Base
    extend Forwardable

    def_delegators 'Wordpress', :logger
    def_delegators 'logger', :debug, :info, :warn, :error, :fatal

    class << self
      private

      def attr_accessor(*args)
        if args.size == 1 && args.first.is_a?(Hash)
          args.first.each do |key, default|
            define_method key do
              instance_variable_defined?("@#{key}") ? instance_variable_get("@#{key}") : default
            end
            define_method "#{key}=" do |value|
              instance_variable_set("@#{key}", value)
            end
          end
        else
          super
        end
      end

      def class_attribute(*args)
        args.each do |arg|
          class_eval <<-EOS
            class << self
              def #{arg}
                @#{arg}
              end

              def #{arg}=(v)
                @#{arg} = v
              end
            end

            def #{arg}
              self.class.#{arg}
            end
          EOS
        end
      end
    end

    def metaclass
      class << self; self; end
    end
  end
end
