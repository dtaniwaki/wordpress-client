require "wordpress/ostruct"

module Wordpress::API
  module Taxonomy
    def get_category(site, slug, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/categories/slug:#{slug}", params))
    end

    def update_category(site, slug, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/categories/slug:#{slug}", params, data))
    end

    def get_tag(site, slug, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/tags/slug:#{slug}", params))
    end

    def update_tag(site, slug, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/tags/slug:#{slug}", params, data))
    end

    def create_category(site, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/categories/new", params, data))
    end

    def create_tag(site, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/tags/new", params, data))
    end

    def delete_category(site, slug, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/categories/slug:#{slug}/delete", params, data))
    end

    def delete_tag(site, slug, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/tags/slug:#{slug}/delete", params, data))
    end
  end
end
