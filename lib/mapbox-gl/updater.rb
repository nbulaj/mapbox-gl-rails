# frozen_string_literal: true

require 'thor'

class Updater < Thor
  include Thor::Actions

  # Base assets storage URL
  BASE_URL = 'https://api.tiles.mapbox.com/mapbox-gl-js'.freeze

  desc 'update assets', 'update assets from the MapBox S3 storage'
  def update
    self.destination_root = 'app/assets'

    get File.join(BASE_URL, "v#{MapboxGl::Rails::VERSION::STRING}/mapbox-gl-dev.js"), 'javascripts/mapbox-gl.js'
    get File.join(BASE_URL, "v#{MapboxGl::Rails::VERSION::STRING}/mapbox-gl.css"), 'stylesheets/mapbox-gl.css'

    inside destination_root do
      run('sass-convert -F css -T scss stylesheets/mapbox-gl.css stylesheets/mapbox-gl.scss')
    end

    remove_file 'stylesheets/mapbox-gl.css'

    #https://www.mapbox.com/mapbox-gl-js/plugins/
    plugins = [:geocoder]
    for plugin in plugins
      plugin_base_url = BASE_URL+"/plugins/mapbox-gl-#{plugin}"
      #GEOCODER VERSION
      get File.join(plugin_base_url, "v#{MapboxGl::Rails.send(plugin)}/mapbox-gl-#{plugin}.min.js"), "javascripts/mapbox-gl-#{plugin}.js"
      get File.join(plugin_base_url, "v#{MapboxGl::Rails.send(plugin)}/mapbox-gl-#{plugin}.css"), "stylesheets/mapbox-gl-#{plugin}.css"

      inside destination_root do
        run("sass-convert -F css -T scss stylesheets/mapbox-gl-#{plugin}.css stylesheets/mapbox-gl-#{plugin}.scss")
      end

      remove_file "stylesheets/mapbox-gl-#{plugin}.css"
    end
  end
end
