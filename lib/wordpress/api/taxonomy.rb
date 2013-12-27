require "wordpress/ostruct"

register_api :get_category, :get, "/rest/v1/sites/$site/categories/slug:$category",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :update_category, :post, "/rest/v1/sites/$site/categories/slug:$category",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }
  
register_api :get_tag, :get, "/rest/v1/sites/$site/tags/slug:$tag",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :update_tag, :post, "/rest/v1/sites/$site/tags/slug:$tag",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :create_category, :post, "/rest/v1/sites/$site/categories/new",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :create_tag, :post, "/rest/v1/sites/$site/tags/new",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :delete_category, :post, "/rest/v1/sites/$site/categories/slug:$category/delete",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :delete_tag, :post, "/rest/v1/sites/$site/tags/slug:$tag/delete",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

