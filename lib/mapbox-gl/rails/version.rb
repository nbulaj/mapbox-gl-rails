# frozen_string_literal: true

module MapboxGl
  module Rails
    ##
    # Mapbox GL JS & gem version.
    def self.gem_version
      Gem::Version.new VERSION::STRING
    end

    ##
    # ProxyFetcher gem semantic versioning.
    module VERSION
      # Major version number
      MAJOR = 1
      # Minor version number
      MINOR = 6
      # Smallest version number
      TINY = 1

      # Full version number
      STRING = [MAJOR, MINOR, TINY].compact.join('.')
    end
  end
end
