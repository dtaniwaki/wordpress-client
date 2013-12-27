require "wordpress/object/comments"
require "wordpress/object/comment"

register_api :get_comments, :get, "/rest/v1/sites/$site/comments",
  [:context, :type, :status] + default_keys + search_keys,
  lambda{ |json| Wordpress::Object::Comments.new(self, json) }

register_api :get_post_comments, :get, "/rest/v1/sites/$site/posts/$post_id/replies",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Comments.new(self, json) }

register_api :get_comment, :get, "/rest/v1/sites/$site/comments/$comment_id",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Comment.new(self, json) }

register_api :update_comment, :post, "/rest/v1/sites/$site/comments/$comment_id",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Comment.new(self, json) }

register_api :create_comment, :post, "/rest/v1/sites/$site/comments/$site_id/replies/new",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Comment.new(self, json) }

register_api :delete_comment, :post, "/rest/v1/sites/$site/comments/$comment_id/delete",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Comment.new(self, json) }
