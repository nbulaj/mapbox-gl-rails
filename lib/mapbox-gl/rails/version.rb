# frozen_string_literal: true

module MapboxGl
  module Rails
    ##
    # Mapbox GL JS & gem version.
    def self.gem_version
      Gem::Version.new VERSION::STRING
    end

    ##
    # Follows Mapbox GL JS versioning.
    module VERSION
      # Major version number
      MAJOR = 2
      # Minor version number
      MINOR = 9
      # Smallest version number
      TINY = 0

      # Full version number
      STRING = [MAJOR, MINOR, TINY].compact.join('.')
    end
  end
end
