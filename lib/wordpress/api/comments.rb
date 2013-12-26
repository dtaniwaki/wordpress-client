require 'wordpress/api/utils'

module Wordpress
  module API
    module Posts
      include Wordpress::API::Utils

      def get_comments(site, params = {})
        validate_params! params, [:context, :type, :status], :search
        object_from_response Wordpress::Object::Comments.new(self), Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/comments", params)
      end

      def get_post_comments(site, post_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Comments.new(self), Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}/replies", params)
      end

      def get_comment(site, comment_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Comment.new(self), Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/comments/#{comment_id}", params)
      end

      def update_comment(site, comment_id, data, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Comment.new(self), Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/comments/#{comment_id}", params, data)
      end

      def create_comment(site, post_id, data, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Comment.new(self), Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/replies/new", params, data)
      end

      def delete_comment(site, comment_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Object::Comment.new(self), Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/comments/#{comment_id}/delete", params)
      end
    end
  end
end
