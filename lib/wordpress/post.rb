require 'wordpress/object'
require 'wordpress/user'
require 'wordpress/ostruct'

module Wordpress
  class Post < Wordpress::Object
    attr_parameter :id, :modified, :title, :url, :short_url, :content, :excerpt, :slug, :status, :password, :parent, :type, :comments_open, :pings_open, :comment_count, :like_count, :i_like, :is_reblogged, :is_following, :featured_image, :format, :geo, :publicize_urls, :tags, :categories, :attachments, :metadata
    attr_parameter :date, :as => lambda { |t| DateTime.iso8601(t) }
    attr_parameter :author, :as => Wordpress::User
    attr_parameter :meta, :as => Wordpress::OpenStruct
  end
end
