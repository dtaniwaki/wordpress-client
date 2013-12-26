require_relative 'array'

module Wordpress::Object
  class Comments < Array
    attr_parameter :found
    attr_array :comments, 'Comment'
  end
end
