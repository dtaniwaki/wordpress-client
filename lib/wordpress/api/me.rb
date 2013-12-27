require "wordpress/ostruct"
require "wordpress/object/user"

register_api :me, :get, "/rest/v1/me",
  default_keys,
  lambda{ |json| Wordpress::Object::User.new(self, json) }

register_api :get_my_likes, :get, "/rest/v1/me/likes",
  default_keys,
  lambda{ |json| Wordpress::OpenStruct.new(json) }
