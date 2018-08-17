require 'test_helper'

class MapboxRailsDirectionsPluginTest < ActionDispatch::IntegrationTest
  teardown { clean_sprockets_cache }

  def plugin
    :directions
  end

  test "javascript are served" do
    get "/assets/mapbox-gl-#{plugin}.js"
    assert_mapbox_gl_plugin(response)
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

  def assert_mapbox_gl_css_plugin(response, pattern = /mapbox-directions-origin/)
    assert_response :success
    assert_match(pattern, response.body)
  end

  def assert_mapbox_gl_plugin(response, pattern = /fetchDirections/)
    assert_response :success
    assert_match(pattern, response.body)
  end
end
