# Mapbox for Rails

[![Gem Version](https://badge.fury.io/rb/mapbox-gl-rails.svg)](http://badge.fury.io/rb/mapbox-gl-rails)
[![Build Status](https://travis-ci.org/nbulaj/mapbox-gl-rails.svg?branch=master)](https://travis-ci.org/nbulaj/mapbox-gl-rails)
[![License](http://img.shields.io/badge/license-MIT-brightgreen.svg)](#license)

`mapbox-gl-rails` provides the [Mapbox GL JS](https://github.com/mapbox/mapbox-gl-js) library as a Rails engine for
use with the asset pipeline. It uses the same versioning as the Mapbox GL JS.

Supports Rails >= 3.2 (see [Travis build matrix]((.travis.yml))).

## Installation

Add this to your Gemfile:

```ruby
gem 'mapbox-gl-rails'
```

and run `bundle install`.

## Usage

In your `application.js`, include the following:

```js
//
//*= require mapbox-gl
//= require_tree .
```

In your `application.css`, include the css file:

```css
/*
 *= require mapbox-gl
 */
```

Then restart your webserver if it was previously running.

Congrats! You now have Mapbox GL JS on board and check out the
[Mapbox Examples](https://www.mapbox.com/mapbox-gl-js/examples).

If you need to use any available plugins, then don't forget to add them to `application.js` and `application.css`:

JS:

```js
//*= require mapbox-gl-geocoder
// ...
````

CSS:

```css
/*
 *= require mapbox-gl-geocoder
 *= require mapbox-gl-draw
 *= require mapbox-gl-directions
 *= require mapbox-gl-compare
 ...
 */
```

Full list of integrated plugins you could find [here](https://github.com/nbulaj/mapbox-gl-rails/blob/master/plugins.yaml).

### Sass Support

If you prefer [SCSS](http://sass-lang.com/documentation/file.SASS_REFERENCE.html), add this to your
`application.css.scss` file:

```scss
@import 'mapbox-gl';
```

If you use the [Sass indented syntax](http://sass-lang.com/docs/yardoc/file.INDENTED_SYNTAX.html),
add this to your `application.css.sass` file:

```sass
@import mapbox-gl
```

## Misc

### Rails engines

When building a Rails engine that includes mapbox-gl-rails as a dependency,
be sure to `require "mapbox-gl-rails"` somewhere during the intialization of
your engine. Otherwise, Rails will not automatically pick up the load path of
the mapbox-gl-rails assets and helpers.

### Deploying to sub-folders

It is sometimes the case that deploying a Rails application to a production
environment requires the application to be hosted at a sub-folder on the server.
This may be the case, for example, if Apache HTTPD or Nginx is being used as a
front-end proxy server, with Rails handling only requests that come in to a sub-folder
such as `http://example.com/myrailsapp`. In this case, the
MapboxRails gem (and other asset-serving engines) needs to know the sub-folder,
otherwise you can experience a problem roughly described as ["my app works
fine in development, but fails when I deploy
it"](https://github.com/bokmann/font-awesome-rails/issues/74).

To fix this, set the *relative URL root* for the application. In the
environment file for the deployed version of the app, for example
`config/environments/production.rb`,
set the config option `action_controller.relative_url_root`:

    MyApp::Application.configure do
      ...

      # set the relative root, because we're deploying to /myrailsapp
      config.action_controller.relative_url_root  = "/myrailsapp"

      ...
    end

The default value of this variable is taken from `ENV['RAILS_RELATIVE_URL_ROOT']`,
so configuring the environment to define `RAILS_RELATIVE_URL_ROOT` is an alternative strategy.

In addition you need to indicate the subfolder when you *precompile* the assets:

    RAILS_ENV=production bundle exec rake assets:precompile RAILS_RELATIVE_URL_ROOT=/myrailsapp

### Rails 3.2

**Note:** In Rails 3.2, make sure mapbox-gl-rails is outside the bundler asset group
so that these helpers are automatically loaded in production environments.

## Versioning

Versioning follows the core releases of Mapbox GL JS which follows Semantic
Versioning 2.0 as defined at <http://semver.org>. We will do our best not to
make any breaking changes until Mapbox core makes a major version bump.

Additional build number can be added to fix internal gem errors (like 0.43.0.**0**).

## License

* The [Mapbox GL JS](https://github.com/mapbox/mapbox-gl-js) and it's components are
  licensed under [their own licenses](https://github.com/mapbox/mapbox-gl-js/blob/master/LICENSE.txt).
* The remainder of the mapbox-gl-rails project is licensed under the
  [MIT License](http://opensource.org/licenses/mit-license.html).
