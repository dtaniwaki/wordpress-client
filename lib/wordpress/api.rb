require 'wordpress/api/me'
require 'wordpress/api/sites'
require 'wordpress/api/posts'
require 'wordpress/api/tests'

module Wordpress
  module API
    def self.included(base)
      base.class_eval do
        include Wordpress::API::Me
        include Wordpress::API::Sites
        include Wordpress::API::Posts
        include Wordpress::API::Tests
      end
    end
  end
end
