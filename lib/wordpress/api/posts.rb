require "wordpress/ostruct"
require "wordpress/object/posts"
require "wordpress/object/post"

register_api :get_posts, :get, "/rest/v1/sites/$site/posts",
  [:context, :tag, :category, :type, :status, :sticky, :author, :search, :meta_key, :meta_value] + default_keys + search_keys,
  lambda{ |json| Wordpress::Object::Posts.new(self, json) }

register_api :get_post, :get, "/rest/v1/sites/$site/posts/$post_id",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Post.new(self, json) }

register_api :update_post, :post, "/rest/v1/sites/$site/posts/$post_id",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Post.new(self, json) }

register_api :get_post_by_slug, :get, "/rest/v1/sites/$site/posts/slug:$post_slug",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Post.new(self, json) }

register_api :create_post, :post, "/rest/v1/sites/$site/posts/new",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Post.new(self, json) }

register_api :delete_post, :post, "/rest/v1/sites/$site/posts/$post_id/delete",
  [:context] + default_keys,
  lambda{ |json| Wordpress::Object::Post.new(self, json) }

register_api :get_likes, :get, "/rest/v1/sites/$site/posts/$post_id/likes",
  default_keys,
  lambda{ |json| Wordpress::OpenStruct.new(json) }

register_api :create_like, :post, "/rest/v1/sites/$site/posts/$post_id/likes/new",
  default_keys,
  lambda{ |json| Wordpress::OpenStruct.new(json) }

register_api :delete_like, :post, "/rest/v1/sites/$site/posts/$post_id/likes/mine/delete",
  default_keys,
  lambda{ |json| Wordpress::OpenStruct.new(json) }

register_api :get_like_status, :get, "/rest/v1/sites/$site/posts/$post_id/likes/mine",
  default_keys,
  lambda{ |json| Wordpress::OpenStruct.new(json) }

register_api :get_reblog_status, :get, "/rest/v1/sites/$site/posts/$post_id/reblogs/mine",
  default_keys,
  lambda{ |json| Wordpress::OpenStruct.new(json) }

register_api :create_reblog, :post, "/rest/v1/sites/$site/posts/$post_id/reblogs/new",
  default_keys,
  lambda{ |json| Wordpress::OpenStruct.new(json) }
