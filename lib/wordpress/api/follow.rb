require "wordpress/ostruct"

module Wordpress::API
  module Follow
    def create_follow(site, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/follows/new", params, data))
    end

    def delete_follow(site, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/follows/mine/delete", params, data))
    end

    def get_follow(site, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/follows/mine", params))
    end
  end
end
