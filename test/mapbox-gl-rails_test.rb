require 'test_helper'

class MapboxRailsTest < ActionDispatch::IntegrationTest
  teardown { clean_sprockets_cache }

  test 'engine is loaded' do
    assert_equal ::Rails::Engine, MapboxGL::Rails::Engine.superclass
  end

  test 'javascript are served' do
    get '/assets/mapbox-gl.js'
    assert_mapbox_gl_js(response)
  end

  test 'stylesheets are served' do
    get '/assets/mapbox-gl.css'
    assert_mapbox_gl_css(response)
  end

  test 'stylesheet is available in a css sprockets require' do
    get '/assets/sprockets-require.css'
    assert_mapbox_gl_css(response)
  end

  test 'stylesheet is available in a sass import' do
    get '/assets/sass-import.css'
    assert_mapbox_gl_css(response)
  end

  test 'stylesheet is available in a scss import' do
    get '/assets/scss-import.css'
    assert_mapbox_gl_css(response)
  end

  private

  def clean_sprockets_cache
    FileUtils.rm_rf File.expand_path('../dummy/tmp',  __FILE__)
  end

  def assert_mapbox_gl_css(response)
    assert_response :success
    assert_match(/mapboxgl-map/, response.body)
  end

  def assert_mapbox_gl_js(response)
    assert_response :success
    assert_match(/window\.mapboxgl/, response.body)
  end
end
