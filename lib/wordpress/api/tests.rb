require "wordpress/object/test"

test_keys = [:id, :default_string, :default_int, :boolean_whitelist_defaults_to_false, :boolean_whitelist_defaults_to_true, :string_whitelist_defaults_to_foo, :url, :datetime]

register_api :get_test, :get, "/rest/v1/test/$id",
  test_keys,
  lambda{ |json| Wordpress::Object::Test.new(self, json) }

register_api :post_test, :post, "/rest/v1/test/$id",
  test_keys,
  lambda{ |json| Wordpress::Object::Test.new(self, json) }
