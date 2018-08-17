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
      MAJOR = 0
      # Minor version number
      MINOR = 47
      # Smallest version number
      TINY = 0

      # Full version number
      STRING = [MAJOR, MINOR, TINY].compact.join('.')
    end

    #https://www.mapbox.com/mapbox-gl-js/plugins/
    def self.geocoder; '2.3.0' end 
  end
end
