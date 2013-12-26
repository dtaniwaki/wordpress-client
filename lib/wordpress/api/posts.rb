require 'wordpress/api/utils'

module Wordpress
  module API
    module Posts
      include Wordpress::API::Utils

      def get_posts(site, params = {})
        validate_params! params, [:context, :tag, :category, :type, :status, :sticky, :author, :search, :meta_key, :meta_value], :search
        object_from_response Wordpress::Object::Posts.new(self), Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts", params)
      end

      def get_post(site, post_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Post.new(self), Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}", params)
      end

      def update_post(site, post_id, data, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Post.new(self), Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}", params, data)
      end

      def get_post_by_slug(site, post_slug, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Post.new(self), Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/slug:#{post_slug}", params)
      end

      def create_post(site, post_id, data, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Post.new(self), Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/new", params, data)
      end

      def delete_post(site, post_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Post.new(self), Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/delete", params)
      end

      def get_likes(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::Ostruct.new, Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}/likes", params)
      end

      def create_like(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::Ostruct.new, Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/likes/new", params)
      end

      def delete_like(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::Ostruct.new, Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/likes/mine/delete", params)
      end

      def get_like_status(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::Ostruct.new, Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}/likes/mine", params)
      end

      def get_reblog_status(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::Ostruct.new, Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}/reblogs/mine", params)
      end

      def create_reblog(site, post_id, data, params = {})
        validate_params! params
        object_from_response Wordpress::Ostruct.new, Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/reblogs/new", params, data)
      end
    end
  end
end
