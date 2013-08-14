require 'wordpress/api/utils'

module Wordpress
  module API
    module Posts
      include Wordpress::API::Utils

      def get_posts(site, params = {})
        validate_params! params, [:context, :tag, :category, :type, :status, :sticky, :author, :search, :meta_key, :meta_value], :search
        object_from_response Wordpress::PostArray, "/sites/#{site}/posts", :get, :query => params
      end

      def get_post(site, post_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Post, "/sites/#{site}/posts/#{post_id}", :get, :query => params
      end

      def update_post(site, post_id, data, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Post, "/sites/#{site}/posts/#{post_id}", :post, :request => data, :query => params
      end

      def get_post_by_slug(site, post_slug, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Post, "/sites/#{site}/posts/slug:#{post_slug}", :get, :query => params
      end

      def create_post(site, post_id, data, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Post, "/sites/#{site}/posts/new", :post, :request => data, :query => params
      end

      def delete_post(site, post_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Post, "/sites/#{site}/posts/#{post_id}/delete", :post, :query => params
      end

      def get_likes(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::LikeArray, "/sites/#{site}/posts/#{post_id}/likes", :get, :query => params
      end

      def create_like(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::OpenStruct, "/sites/#{site}/posts/#{post_id}/likes/new", :post, :query => params
      end

      def delete_like(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::OpenStruct, "/sites/#{site}/posts/#{post_id}/likes/mine/delete", :post, :query => params
      end

      def get_like_status(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::OpenStruct, "/sites/#{site}/posts/#{post_id}/likes/mine", :get, :query => params
      end

      def get_reblog_status(site, post_id, params = {})
        validate_params! params
        object_from_response Wordpress::OpenStruct, "/sites/#{site}/posts/#{post_id}/reblogs/mine", :get, :query => params
      end

      def create_reblog(site, post_id, data, params = {})
        validate_params! params
        object_from_response Wordpress::OpenStruct, "/sites/#{site}/posts/#{post_id}/reblogs/new", :post, :request => data, :query => params
      end
    end
  end
end
