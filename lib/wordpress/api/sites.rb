require 'wordpress/api/utils'

module Wordpress
  module API
    module Sites
      include Wordpress::API::Utils

      def get_site(site, params = {})
        validate_params! params
        object_from_response Wordpress::Object::Site.new(self), Wordpress::Request.new(:get, "/rest/v1/sites/#{site}", params)
      end
    end
  end
end
