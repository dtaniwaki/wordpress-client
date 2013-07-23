require 'wordpress/array'
require 'wordpress/comment'

module Wordpress
  class CommentArray < Wordpress::Array
    attr_parameter :found
    attr_parameter :comments, :as => lambda { |array| array.nil? ? [] : array.map { |v| Wordpress::Comment.new(v) } }
    array_delegator :@comments
  end
end
