require "wordpress/ostruct"

register_api :freshly_pressed, :get, "/rest/v1/freshly-pressed",
  [:number, :after, :before, :content_width, :thumb_width, :thumb_height] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }
