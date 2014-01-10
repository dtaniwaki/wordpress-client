module Wordpress
  class Version
    MAJOR = 0 unless defined? Wordpress::Version::MAJOR
    MINOR = 2 unless defined? Wordpress::Version::MINOR
    PATCH = 3 unless defined? Wordpress::Version::PATCH
    PRE = nil unless defined? Wordpress::Version::PRE

    class << self
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end
    end
  end
end
