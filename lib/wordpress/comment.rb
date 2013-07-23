require 'wordpress/object'
require 'wordpress/user'
require 'wordpress/post'
require 'wordpress/ostruct'

module Wordpress
  class Comment < Wordpress::Object
    attr_parameter :id, :url, :short_url, :content, :status, :parent, :string
    attr_parameter :date, :as => lambda { |t| DateTime.iso8601(t) }
    attr_parameter :post, :as => Wordpress::Post
    attr_parameter :author, :as => Wordpress::User
    attr_parameter :meta, :as => Wordpress::OpenStruct
  end
end
