# frozen_string_literal: true

require 'thor'
require 'yaml'

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

    # https://www.mapbox.com/mapbox-gl-js/plugins/
    #
    plugins = YAML.load_file('plugins.yaml').fetch('plugins')

    plugins.each do |plugin_name, options|
      plugin_base_url = File.join(BASE_URL, "/plugins/mapbox-gl-#{plugin_name}")
      plugin_version = options.fetch('version')

      begin
        get File.join(plugin_base_url, "v#{plugin_version}/#{options.fetch('js')}"), "javascripts/mapbox-gl-#{plugin_name}.js"
        get File.join(plugin_base_url, "v#{plugin_version}/#{options.fetch('css')}"), "stylesheets/mapbox-gl-#{plugin_name}.css"

        inside destination_root do
          run("sass-convert -F css -T scss stylesheets/mapbox-gl-#{plugin_name}.css stylesheets/mapbox-gl-#{plugin_name}.scss")
        end

        remove_file "stylesheets/mapbox-gl-#{plugin_name}.css"
      rescue KeyError => error
        raise KeyError, "#{error.message} for #{plugin_name} plugin!"
      rescue OpenURI::HTTPError => error
        raise "#{plugin_name} v#{plugin_version} could not be downloaded (#{error.message})!"
      end
    end
  end
end
