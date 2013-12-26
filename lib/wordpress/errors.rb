module Wordpress
  class Error < ::StandardError
    attr_reader :message

    def initialize(message = nil)
      @message = message
    end

    def to_s
      @message
    end
  end

  class ResponseError < Error
    attr_reader :error

    def initialize(json = {})
      @error = json['error'] || 'unknown'
      super json['message']
    end
  end

  class ArgumentError < Error
  end
end
