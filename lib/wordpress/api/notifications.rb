require "wordpress/ostruct"

register_api :get_notifications, :get, "/rest/v1/notifications",
  [:ids, :fields, :type, :unread, :read, :number, :since, :before, :num_note_items, :trap] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :get_notification, :get, "/rest/v1/notifications/$note_id",
  [:context, :fields, :num_note_items] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :seen_notification, :post, "/rest/v1/notifications/seen",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

register_api :read_notification, :post, "/rest/v1/notifications/read",
  [:context] + default_keys,
  lambda{ |json|
    Wordpress::OpenStruct.new(json)
  }

