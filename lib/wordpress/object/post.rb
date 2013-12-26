require_relative 'meta_object'

module Wordpress::Object
  class Post < MetaObject
    attr_parameter :id, :modified, :title, :url, :short_url, :content, :excerpt, :slug, :status, :password, :parent, :type, :comments_open, :pings_open, :comment_count, :like_count, :i_like, :is_reblogged, :is_following, :featured_image, :format, :geo, :publicize_urls, :tags, :categories, :attachments, :metadata
    attr_parameter :date, :as => lambda { |c, v| DateTime.iso8601(v) }
    attr_parameter :author, :as => 'User'
    attr_meta_object :site => 'Site', :replies => 'Comments'
  end
end
