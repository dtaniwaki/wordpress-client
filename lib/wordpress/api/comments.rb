require 'wordpress/api/utils'

module Wordpress
  module API
    module Posts
      include Wordpress::API::Utils

      def get_comments(site, params = {})
        validate_params! params, [:context, :type, :status], :type => :search
        object_from_response Wordpress::CommentArray, "/sites/#{site}/comments", :get, :query => params
      end

      def get_post_comments(site, post_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::CommentArray, "/sites/#{site}/posts/#{post_id}/replies", :get, :query => params
      end

      def get_comment(site, comment_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Comment, "/sites/#{site}/comments/#{comment_id}", :get, :query => params
      end

      def update_comment(site, comment_id, data, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Comment, "/sites/#{site}/comments/#{comment_id}", :post, :request => data, :query => params
      end

      def create_comment(site, post_id, data, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Comment, "/sites/#{site}/posts/#{post_id}/replies/new", :post, :request => data, :query => params
      end

      def delete_comment(site, comment_id, params = {})
        validate_params! params, [:context]
        object_from_response Wordpress::Comment, "/sites/#{site}/comments/#{comment_id}/delete", :post, :query => params
      end
    end
  end
end
