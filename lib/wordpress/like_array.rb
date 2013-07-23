require 'wordpress/array'

module Wordpress
  class LikeArray < Wordpress::Array
    attr_parameter :found, :i_like
    attr_parameter :likes, :as => lambda { |array| array.nil? ? [] : array.map { |v| Wordpress::User.new(v) } }
    array_delegator :@likes
  end
end
