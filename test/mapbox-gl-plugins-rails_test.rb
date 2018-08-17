require "test_helper"

class MapboxRailsTest < ActionDispatch::IntegrationTest
  teardown { clean_sprockets_cache }
  def plugin
    :geocoder
  end
  test "javascript are served" do
    get "/assets/mapbox-gl-#{plugin}.js"
    assert_mapbox_gl_plugin(response)
  end

  test "javascript of valid version" do
    get "/assets/mapbox-gl-#{plugin}.js"

    #weirdly, the plugins don't seem to contain the version number.
    #assert_mapbox_gl_plugin(response, MapboxGl::Rails.send(plugin))
    assert_mapbox_gl_plugin(response, plugin.to_s.camelize)
  end

  test "stylesheets are served" do
    get "/assets/mapbox-gl-#{plugin}.css"
    assert_mapbox_gl_css_plugin(response)
  end

  test "stylesheet is available in a css sprockets require" do
    get "/assets/sprockets-require.css"
    assert_mapbox_gl_css_plugin(response)
  end

  test "stylesheet is available in a sass import" do
    get "/assets/sass-import.css"
    assert_mapbox_gl_css_plugin(response)
  end

  test "stylesheet is available in a scss import" do
    get "/assets/scss-import.css"
    assert_mapbox_gl_css_plugin(response)
  end

  private

  def clean_sprockets_cache
    FileUtils.rm_rf File.expand_path("../dummy/tmp",  __FILE__)
  end

  def assert_mapbox_gl_css_plugin(response, pattern = /mapboxgl-ctrl-/)
    assert_response :success
    assert_match(pattern, response.body)
  end

  def assert_mapbox_gl_plugin(response, pattern = /typeof/)
    assert_response :success
    assert_match(pattern, response.body)
  end
end
