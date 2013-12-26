require_relative 'meta_object'

module Wordpress::Object
  class Site < MetaObject
    attr_parameter :id, :name, :description, :url, :jetpack, :post_count, :lang
    attr_meta_object :posts => 'Posts', :comments => 'Comments'
  end
end
