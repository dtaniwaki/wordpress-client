require "wordpress/ostruct"

register_api :create_follow, :post, "/rest/v1/sites/$site/follows/new",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :delete_follow, :post, "/rest/v1/sites/$site/follows/mine/delete",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :get_follow, :get, "/rest/v1/sites/$site/follows/mine",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }
