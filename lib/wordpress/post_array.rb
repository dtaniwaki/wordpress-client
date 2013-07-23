require 'wordpress/array'
require 'wordpress/post'

module Wordpress
  class PostArray < Wordpress::Array
    attr_parameter :found
    attr_parameter :posts, :as => lambda { |array| array.nil? ? [] : array.map { |v| Wordpress::Post.new(v) } }
    array_delegator :@posts
  end
end
