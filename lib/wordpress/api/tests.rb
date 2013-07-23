require 'wordpress/api/utils'

module Wordpress
  module API
    module Tests
      include Wordpress::API::Utils

      def get_test(id, options = {})
        validate_options! options, [:id, :default_string, :default_int, :boolean_whitelist_defaults_to_false, :boolean_whitelist_defaults_to_true, :string_whitelist_defaults_to_foo, :url, :datetime], :type => :test
        object_from_response Wordpress::Test, "/test/#{id}", :get, options
      end

      def post_test(id, options = {})
        validate_options! options, [:id, :default_string, :default_int, :boolean_whitelist_defaults_to_false, :boolean_whitelist_defaults_to_true, :string_whitelist_defaults_to_foo, :url, :datetime], :type => :test
        object_from_response Wordpress::Test, "/test/#{id}", :post, options
      end
    end
  end
end
