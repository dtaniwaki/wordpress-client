require_relative 'meta_object'

module Wordpress::Object
  class User < MetaObject
    attr_parameter :id, :display_name, :username, :email, :primary_blog, :token_site_id, :avatar_url, :profile_url, :verified
    attr_meta_object :site => 'Site'
  end
end
