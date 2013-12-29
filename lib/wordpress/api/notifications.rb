require "wordpress/ostruct"

module Wordpress::API
  module Notifications
    def get_notifications(params = {})
      validate_keys! params, [:ids, :fields, :type, :unread, :read, :number, :since, :before, :num_note_items, :trap] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/notifications", params))
    end

    def get_notification(note_id, params = {})
      validate_keys! params, [:context, :fields, :num_note_items] + default_keys
      exec_api(Wordpress::Request.new(:get, "/rest/v1/notifications/#{note_id}", params))
    end

    def see_notifications(data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/notifications/seen", params, data))
    end

    def read_notifications(data, params = {})
      validate_keys! params, [:context] + default_keys
      exec_api(Wordpress::Request.new(:post, "/rest/v1/notifications/read", params, data))
    end
  end
end
