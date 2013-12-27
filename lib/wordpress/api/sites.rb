require "wordpress/object/site"

register_api :get_site, :get, "/rest/v1/sites/$site",
  default_keys,
  lambda{ |json| Wordpress::Object::Site.new(self, json) }
