require 'wordpress/object'
require 'wordpress/ostruct'

module Wordpress
  class Site < Wordpress::Object
    attr_parameter :id, :name, :description, :url, :jetpack, :post_count, :lang
    attr_parameter :meta, :as => Wordpress::OpenStruct
  end
end
