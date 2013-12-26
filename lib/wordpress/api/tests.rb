require 'wordpress/api/utils'

module Wordpress
  module API
    module Tests
      include Wordpress::API::Utils

      def get_test(id, params = {})
        validate_params! params, test_keys
        object_from_response Wordpress::Object::Test.new(self), Wordpress::Request.new(:get, "/rest/v1/test/#{id}", params)
      end

      def post_test(id, params = {})
        validate_params! params, test_keys
        object_from_response Wordpress::Object::Test.new(self), Wordpress::Request.new(:post, "/rest/v1/test/#{id}",  params)
      end

      private

      def test_keys
        [:id, :default_string, :default_int, :boolean_whitelist_defaults_to_false, :boolean_whitelist_defaults_to_true, :string_whitelist_defaults_to_foo, :url, :datetime]
      end
    end
  end
end
