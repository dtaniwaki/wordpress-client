require_relative 'base'

module Wordpress::Object
  class Array < Base
    class_attribute :array_name

    class << self
      private

      def attr_array(name, klass)
        name = name.to_s
        self.array_name = name
        def_delegators name, 'each', 'map', 'select', 'reject', 'find', 'find_all', 'any?', 'all?', 'size'
        attr_parameter name, :as => lambda{ |client, array|
          (array || []).map{ |v|
            Wordpress::Object.const_get(klass).new(client, v)
          }
        }
      end
    end

    def [](k)
      if k.is_a?(Fixnum) && array_name.to_s != ''
        send(array_name)[k]
      else
        send(k)
      end
    end
  end
end
