require "wordpress/ostruct"
require "wordpress/object/posts"
require "wordpress/object/post"

module Wordpress::API
  module Posts
    def get_posts(site, params = {})
      validate_keys! params, [:context, :tag, :category, :type, :status, :sticky, :author, :search, :meta_key, :meta_value] + default_keys + search_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts", params)) do |json|
        Wordpress::Object::Posts.new(self, json)
      end
    end

    def get_post(site, post_id, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}", params)) do |json|
        Wordpress::Object::Post.new(self, json)
      end
    end

    def update_post(site, post_id, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}", params, data)) do |json|
        Wordpress::Object::Post.new(self, json)
      end
    end

    def get_post_by_slug(site, slug, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/slug:#{slug}", params)) do |json|
        Wordpress::Object::Post.new(self, json)
      end
    end

    def create_post(site, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/new", params, data)) do |json|
        Wordpress::Object::Post.new(self, json)
      end
    end

    def delete_post(site, post_id, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/delete", params, data)) do |json|
        Wordpress::Object::Post.new(self, json)
      end
    end

    def get_likes(site, post_id, params = {})
      validate_keys! params, default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}/likes", params))
    end

    def create_like(site, post_id, data, params = {})
      validate_keys! params, default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/likes/new", params, data))
    end

    def delete_like(site, post_id, data, params = {})
      validate_keys! params, default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/likes/mine/delete", params, data))
    end

    def get_like_status(site, post_id, params = {})
      validate_keys! params, default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}/likes/mine", params))
    end

    def get_reblog_status(site, post_id, params = {})
      validate_keys! params, default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}/reblogs/mine", params))
    end

    def create_reblog(site, post_id, data, params = {})
      validate_keys! params, default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/reblogs/new", params, data))
    end
  end
end
