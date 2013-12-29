require "wordpress/ostruct"
require "wordpress/object/user"

module Wordpress::API
  module Me
    def me(params = {})
      validate_keys! params, default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/me", params)) do |json|
        Wordpress::Object::User.new(self, json)
      end
    end

    def get_my_likes(params = {})
      validate_keys! params, default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/me/likes", params))
    end
  end
end
