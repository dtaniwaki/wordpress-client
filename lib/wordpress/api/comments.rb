require "wordpress/object/comments"
require "wordpress/object/comment"

module Wordpress::API
  module Comments
    def get_comments(site, params = {})
      validate_keys! params, [:context, :type, :status] + default_keys + search_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/comments", params)) do |json|
        Wordpress::Object::Comments.new(self, json)
      end
    end

    def get_post_comments(site, post_id, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/posts/#{post_id}/replies", params)) do |json|
        Wordpress::Object::Comments.new(self, json)
      end
    end

    def get_comment(site, comment_id, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/sites/#{site}/comments/#{comment_id}", params)) do |json|
        Wordpress::Object::Comment.new(self, json)
      end
    end

    def update_comment(site, comment_id, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/comments/#{comment_id}", params, data)) do |json|
        Wordpress::Object::Comment.new(self, json)
      end
    end

    def create_comment(site, post_id, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/posts/#{post_id}/replies/new", params, data)) do |json|
        Wordpress::Object::Comment.new(self, json)
      end
    end

    def delete_comment(site, comment_id, data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/sites/#{site}/comments/#{comment_id}/delete", params, data)) do |json|
        Wordpress::Object::Comment.new(self, json)
      end
    end
  end
end
