require_relative 'base'

module Wordpress::Object
  class Test < Base
    attr_parameter :method_id_matches_query_id, :method_id, :id, :default_string, :default_int, :boolean_whitelist_defaults_to_false, :boolean_whitelist_defaults_to_true, :string_whitelist_defaults_to_foo, :url, :datetime
  end
end
