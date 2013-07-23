require 'wordpress/api/utils'

module Wordpress
  module API
    module Me
      include Wordpress::API::Utils

      def me(params = {})
        validate_params! params
        object_from_response Wordpress::User, "/me", :get, :query => params
      end

      def get_my_likes(params = {})
        validate_params! params
        object_from_response Wordpress::LikeArray, "/me/likes", :get, :query => params
      end
    end
  end
end
