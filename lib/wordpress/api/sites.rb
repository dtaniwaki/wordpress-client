require "wordpress/object/site"

module Wordpress::API
  module Sites
    def get_site(site, params = {})
      validate_keys! params, default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}", params)) do |json|
        Wordpress::Object::Site.new(self, json)
      end
    end
  end
end
