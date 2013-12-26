require_relative 'array'

module Wordpress::Object
  class Posts < Array
    attr_parameter :found
    attr_array :posts, 'Post'
  end
end
