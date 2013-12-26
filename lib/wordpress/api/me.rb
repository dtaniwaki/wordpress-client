require 'wordpress/api/utils'

module Wordpress
  module API
    module Me
      include Wordpress::API::Utils

      def me(params = {})
        validate_params! params
        object_from_response Wordpress::Object::User.new(self), Wordpress::Request.new(:get, "/rest/v1/me", params)
      end

      def get_my_likes(params = {})
        validate_params! params
        object_from_response Wordpress::Ostruct.new, Wordpress::Request.new(:get, "/rest/v1/me/likes", params)
      end
    end
  end
end
