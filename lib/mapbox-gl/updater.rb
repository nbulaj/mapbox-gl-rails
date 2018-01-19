# frozen_string_literal: true

require 'thor'

class Updater < Thor
  include Thor::Actions

  # Base assets storage URL
  BASE_URL = 'https://api.tiles.mapbox.com/mapbox-gl-js'.freeze

  desc 'update assets', 'update assets from the MapBox S3 storage'
  def update
    self.destination_root = 'app/assets'

    get File.join(BASE_URL, "v#{MapboxGL::Rails::VERSION::STRING}/mapbox-gl-dev.js"), 'javascripts/mapbox-gl.js'
    get File.join(BASE_URL, "v#{MapboxGL::Rails::VERSION::STRING}/mapbox-gl.css"), 'stylesheets/mapbox-gl.css'

    inside destination_root do
      run('sass-convert -F css -T scss stylesheets/mapbox-gl.css stylesheets/mapbox-gl.scss')
    end

    remove_file 'stylesheets/mapbox-gl.css'
  end
end
