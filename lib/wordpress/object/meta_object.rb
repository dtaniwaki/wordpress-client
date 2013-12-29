require_relative 'base'

module Wordpress::Object
  class MetaObject < Base
    class_attribute :meta_objects

    class << self
      def inherited(base)
        base.class_eval do
          attr_parameter :meta
        end
      end

      def attr_meta_object(params)
        self.meta_objects = (meta_objects || {}).merge(Hash[params.map{ |k, v| [k.to_s, v] }])
      end
    end

    def assign(response)
      @cached_objects = {}
      super
    end

    def reload
      if meta && meta.links && meta.links.self
        request = Wordpress::Request.new(:get, meta.links.self)
        client.exec_api(request) do |json|
          self.assign(json)
        end
      end
    end

    def save
      raise NotImplementedError
    end

    def delete
      raise NotImplementedError
    end

    private

    def associated_object?(name)
      name = name.to_s
      @response['meta'] && @response['meta']['links'] && @response['meta']['links'].include?(name) && meta_objects.include?(name)
    end

    def available_object?(name)
      associated_object?(name) || super
    end

    def get_object(name)
      name = name.to_s
      if associated_object?(name)
        @cached_objects[name] ||= begin
          request = Wordpress::Request.new(:get, meta.links.send(name))
          json = client.call(request)
          Wordpress::Object.const_get(meta_objects[name]).new(client, json)
        end
      else
        super
      end
    end
  end
end
