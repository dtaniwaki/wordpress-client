require_relative 'meta_object'

module Wordpress::Object
  class Comment < MetaObject
    attr_parameter :id, :url, :short_url, :content, :status, :parent, :string
    attr_parameter :date, :as => lambda { |c, v| DateTime.iso8601(v) }
    attr_parameter :post, :as => 'Post'
    attr_parameter :author, :as => 'User'
    attr_meta_object :site => 'Site', :post => 'Post', :replies => 'Comments'
  end
end
