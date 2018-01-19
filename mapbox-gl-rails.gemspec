$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'lib'))
require File.expand_path('../lib/mapbox-gl/rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Nikita Bulai']
  gem.email         = ['bulajnikita@gmail.com']
  gem.description   = 'mapbox-gl-rails provides Mapbox GL JS sources and stylesheets as a ' \
                      'Rails engine for use with the asset pipeline.'
  gem.summary       = 'an asset gemification of the Mapbox GL JS library'
  gem.homepage      = 'https://github.com/nbulaj/mapbox-gl-rails'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -- {app,bin,lib,test,spec}/* {LICENSE*,Rakefile,README*}`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec}/*`.split("\n")
  gem.name          = 'mapbox-gl-rails'
  gem.require_paths = ['lib']
  gem.version       = MapboxGL::Rails.gem_version

  gem.add_dependency 'railties', '>= 3.2', '< 5.3'

  gem.add_development_dependency 'activesupport'
  gem.add_development_dependency 'sass-rails'
  gem.add_development_dependency 'thor'

  gem.required_ruby_version = '>= 1.9.3'
end
