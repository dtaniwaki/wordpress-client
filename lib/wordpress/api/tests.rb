require "wordpress/object/test"

module Wordpress::API
  module Tests
    def get_test(id, params = {})
      validate_keys! params, test_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/test/#{id}", params)) do |json|
        Wordpress::Object::Test.new(self, json)
      end
    end

    def post_test(id, data, params = {})
      validate_keys! params, test_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/test/#{id}", params, data)) do |json|
        Wordpress::Object::Test.new(self, json)
      end
    end

    private

    def test_keys
      [:id, :default_string, :default_int, :boolean_whitelist_defaults_to_false, :boolean_whitelist_defaults_to_true, :string_whitelist_defaults_to_foo, :url, :datetime].freeze
    end
  end
end
