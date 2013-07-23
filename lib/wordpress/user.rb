require 'wordpress/object'
require 'wordpress/ostruct'

module Wordpress
  class User < Wordpress::Object
    attr_parameter :id, :display_name, :username, :email, :primary_blog, :avatar_url, :profile_url, :verified
    attr_parameter :meta, :as => Wordpress::OpenStruct
  end
end
