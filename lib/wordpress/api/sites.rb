require 'wordpress/api/utils'

module Wordpress
  module API
    module Sites
      include Wordpress::API::Utils

      def get_site(site, params = {})
        validate_params! params
        object_from_response Wordpress::Site, "/sites/#{site}", :get, :query => params
      end
    end
  end
end
