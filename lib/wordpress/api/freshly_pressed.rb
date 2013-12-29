require "wordpress/ostruct"

module Wordpress::API
  module FreshlyPressed
    def freshly_pressed(params = {})
      validate_keys! params, [:number, :after, :before, :content_width, :thumb_width, :thumb_height] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/freshly-pressed", params))
    end
  end
end
