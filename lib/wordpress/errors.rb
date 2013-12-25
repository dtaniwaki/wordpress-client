module Wordpress
  class ResponseError < StandardError
    attr_reader :error, :message

    def initialize(json = {})
      @error = json['error'] || 'unknown'
      @message = json['message']
    end

    def to_s
      @message
    end
  end
end
