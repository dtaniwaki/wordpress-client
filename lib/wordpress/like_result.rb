require 'wordpress/object'
require 'wordpress/ostruct'

module Wordpress
  class LikeResult < Wordpress::Object
    attr_parameter :success, :i_like, :like_count
    attr_parameter :meta, :as => Wordpress::OpenStruct
  end
end
